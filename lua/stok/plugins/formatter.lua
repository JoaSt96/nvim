return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      notify_on_error = true,
      formatters = {
        biome = {
          command = "biome",
          args = { "check", "--fix", "--unsafe", "--stdin-file-path", "$FILENAME" },
          stdin = true,
          condition = function(self, ctx)
            return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.dirname, upward = true })[1] ~= nil
          end,
        },
      },
      formatters_by_ft = {
        javascript = { "biome", "prettier", stop_after_first = true },
        typescript = { "biome", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettier", stop_after_first = true },
        json = { "biome", "prettier", stop_after_first = true },
        jsonc = { "biome" },
        css = { "biome", "prettier", stop_after_first = true },
        yaml = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
      },
      format_on_save = {
        lsp_format = "never",
        timeout_ms = 3000,
      },
    })
  end,
}
