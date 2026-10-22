local api = vim.api
local lsp = vim.lsp
local util = require("vim.lsp.util")
local ms = require("vim.lsp.protocol").Methods
local uv = vim.uv or vim.loop

local M = {}

local PATH_SEP = package.config:sub(1, 1)

local function normalize_path(path)
  if type(path) ~= "string" or path == "" then
    return nil
  end

  return vim.fs.normalize(uv.fs_realpath(path) or path)
end

local function uri_to_path(uri)
  if type(uri) ~= "string" or uri == "" then
    return nil
  end

  local ok, path = pcall(vim.uri_to_fname, uri)
  if not ok then
    return nil
  end

  return normalize_path(path)
end

local function path_is_in_node_modules(path)
  if not path then
    return false
  end

  local marker = PATH_SEP .. "node_modules" .. PATH_SEP
  return path:find(marker, 1, true) ~= nil or vim.endswith(path, PATH_SEP .. "node_modules")
end

local function is_within_root(path, root)
  if path == root then
    return true
  end

  local prefix = vim.endswith(root, PATH_SEP) and root or (root .. PATH_SEP)
  return vim.startswith(path, prefix)
end

local function collect_workspace_roots(clients)
  local roots = {}
  local seen = {}

  local function add_root(path)
    path = normalize_path(path)
    if not path or seen[path] then
      return
    end

    seen[path] = true
    roots[#roots + 1] = path
  end

  for _, client in ipairs(clients) do
    if client.workspace_folders then
      for _, folder in ipairs(client.workspace_folders) do
        add_root(uri_to_path(folder.uri))
      end
    end

    local root_dir = client.config and client.config.root_dir or client.root_dir
    if type(root_dir) == "string" then
      add_root(root_dir)
    end
  end

  table.sort(roots, function(a, b)
    return #a > #b
  end)

  return roots
end

local function path_is_local(path, roots)
  if not path or path_is_in_node_modules(path) then
    return false
  end

  for _, root in ipairs(roots) do
    if is_within_root(path, root) then
      return true
    end
  end

  return false
end

local function location_range(location)
  return location.targetSelectionRange or location.range or location.targetRange
end

local function format_path_for_display(path, roots)
  for _, root in ipairs(roots) do
    if is_within_root(path, root) then
      local prefix = vim.endswith(root, PATH_SEP) and root or (root .. PATH_SEP)
      return path == root and "." or path:sub(#prefix + 1)
    end
  end

  return vim.fn.fnamemodify(path, ":~:.")
end

local function build_record(location, client, roots)
  local uri = location.targetUri or location.uri
  local path = uri_to_path(uri)
  if not path then
    return nil
  end

  local range = location_range(location)
  local start = range and range.start or { line = 0, character = 0 }

  return {
    client = client,
    location = location,
    path = path,
    line = start.line + 1,
    col = start.character + 1,
    is_local = path_is_local(path, roots),
  }
end

local function collect_records(responses, roots)
  local records = {}
  local seen = {}

  for _, response in ipairs(responses) do
    if response and response.err then
      lsp.log.error(response.err.code, response.err.message)
    end

    local result = response and response.result
    local locations = result and (vim.islist(result) and result or { result }) or {}

    for _, location in ipairs(locations) do
      local record = build_record(location, response.client, roots)
      if record then
        local key = table.concat({ record.path, record.line, record.col }, ":")
        if not seen[key] then
          seen[key] = true
          record.label = string.format(
            "%s:%d:%d",
            format_path_for_display(record.path, roots),
            record.line,
            record.col
          )
          records[#records + 1] = record
        end
      end
    end
  end

  return records
end

local function filter_records(records, predicate)
  local filtered = {}

  for _, record in ipairs(records) do
    if predicate(record) then
      filtered[#filtered + 1] = record
    end
  end

  return filtered
end

local function jump_to_record(record, ctx)
  local win = api.nvim_win_is_valid(ctx.win) and ctx.win or api.nvim_get_current_win()

  if api.nvim_get_current_win() ~= win then
    api.nvim_set_current_win(win)
  end

  vim.cmd("normal! m'")
  vim.fn.settagstack(vim.fn.win_getid(win), {
    items = {
      {
        tagname = ctx.tagname,
        from = ctx.from,
      },
    },
  }, "t")

  util.show_document(record.location, record.client.offset_encoding, {
    focus = true,
    reuse_win = false,
  })
end

local function select_record(records, ctx, is_local)
  local prompt = is_local and "Project definitions" or "External definitions"

  vim.ui.select(records, {
    prompt = prompt,
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if choice then
      jump_to_record(choice, ctx)
    end
  end)
end

function M.goto_definition_prefer_local()
  local bufnr = api.nvim_get_current_buf()
  local method = ms.textDocument_definition
  local clients = lsp.get_clients({ bufnr = bufnr, method = method })

  if not next(clients) then
    vim.notify(lsp._unsupported_method(method), vim.log.levels.WARN)
    return
  end

  local win = api.nvim_get_current_win()
  local from = vim.fn.getpos(".")
  from[1] = bufnr

  local ctx = {
    from = from,
    tagname = vim.fn.expand("<cword>"),
    win = win,
  }

  local roots = collect_workspace_roots(clients)
  local responses = {}
  local remaining = #clients

  for index, client in ipairs(clients) do
    local params = util.make_position_params(win, client.offset_encoding)
    client:request(method, params, function(err, result)
      responses[index] = {
        client = client,
        err = err,
        result = result,
      }

      remaining = remaining - 1
      if remaining > 0 then
        return
      end

      if api.nvim_get_current_buf() ~= bufnr then
        return
      end

      local records = collect_records(responses, roots)
      if vim.tbl_isempty(records) then
        vim.notify("No definition found", vim.log.levels.INFO)
        return
      end

      local local_records = filter_records(records, function(record)
        return record.is_local
      end)

      local candidates = #local_records > 0 and local_records or records
      if #candidates == 1 then
        jump_to_record(candidates[1], ctx)
        return
      end

      select_record(candidates, ctx, #local_records > 0)
    end)
  end
end

return M
