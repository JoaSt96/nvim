return {
  "mason-org/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    require("mason-tool-installer").setup({
      ensure_installed = {
        "lua-language-server",
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        "stylua",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 0,
    })
  end,
}
