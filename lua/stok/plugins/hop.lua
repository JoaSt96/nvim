return {
  "phaazon/hop.nvim",
  keys = {
    { "S", vim.cmd.HopChar2, desc = "Hop to 2 chars" },
    { "s", vim.cmd.HopWord, desc = "Hop to word" },
  },
  config = function()
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
  end,
}
