return {
  "phaazon/hop.nvim",
  config = function()
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    -- KEYMAPS
    vim.keymap.set("n", "S", vim.cmd.HopChar2, { noremap = true, silent = true })
    vim.keymap.set("n", "s", vim.cmd.HopWord)
  end,
}
