return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = function()
		require("lspsaga").setup({})
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
		vim.keymap.set("n", "<C-Space>", "<cmd>Lspsaga code_action<CR>")
		vim.keymap.set("n", "<C-m>", "<cmd>Lspsaga finder<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>rk", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
	end,
}
