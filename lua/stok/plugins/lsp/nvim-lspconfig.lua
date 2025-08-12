return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  event = { "BufReadPre", "BufNewFile" },

  opts = {
    servers = {
      lua_ls = {},
      ts_ls = {},
    },
  },

  config = function(_, opts)
    -- Configure diagnostics
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
    })

    -- Configure hover handler
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = "rounded",
        silent = true,
        focusable = true,
        focus_id = "textDocument/hover",
        close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
      }
    )

    -- Configure signature help
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = "rounded",
        silent = true,
        focusable = false,
      }
    )

    -- Enhanced hover window scrolling
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lsp-hover", "markdown", "help" },
      callback = function(args)
        local buf = args.buf
        vim.keymap.set('n', '<C-f>', '<C-f>', { buffer = buf, desc = 'Scroll down' })
        vim.keymap.set('n', '<C-b>', '<C-b>', { buffer = buf, desc = 'Scroll up' })
        vim.keymap.set('n', '<C-d>', '<C-d>', { buffer = buf, desc = 'Scroll half down' })
        vim.keymap.set('n', '<C-u>', '<C-u>', { buffer = buf, desc = 'Scroll half up' })
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, desc = 'Close hover' })
        vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, desc = 'Close hover' })
      end,
    })

    -- Global keymap to focus hover window
    vim.keymap.set('n', '<C-w>k', function()
      local wins = vim.api.nvim_list_wins()
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if ft == 'markdown' or ft == 'help' or string.match(ft, 'lsp') then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
      vim.cmd('wincmd k')
    end, { desc = 'Focus hover or move up' })

    -- LSP keymaps and optimizations
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        
        if client then
          -- Disable certain features for better performance
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
        
        -- LSP Keymaps
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end
        
        -- Navigation
        map('gd', vim.lsp.buf.definition, 'Go to Definition')
        map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
        map('gi', vim.lsp.buf.implementation, 'Go to Implementation')
        map('gr', vim.lsp.buf.references, 'Go to References')
        map('gt', vim.lsp.buf.type_definition, 'Go to Type Definition')
        
        -- Hover and signature
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<leader>k', vim.lsp.buf.signature_help, 'Signature Help')
        
        -- Workspace
        map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
        map('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'List Workspace Folders')
        
        -- Actions
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ac', vim.lsp.buf.code_action, 'Code Action')
        
        -- Diagnostics
        map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
        map('<leader>e', vim.diagnostic.open_float, 'Show Diagnostic')
        map('<leader>dl', vim.diagnostic.setloclist, 'Diagnostic Location List')
      end,
    })

    -- Setup LSP servers
    local lspconfig = require("lspconfig")
    for server, config in pairs(opts.servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}