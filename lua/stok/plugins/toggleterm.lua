return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      direction = "float",
    })
    vim.keymap.set("n", "<leader>tt", "<cmd>lua require('toggleterm').toggle()<CR>", {
      desc = "Toggle terminal",
    })
  end,
}
