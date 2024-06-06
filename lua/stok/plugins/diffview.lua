return {
	"sindrets/diffview.nvim",
	config = function()
		require('diffview').setup()
		vim.keymap.set('n', '<C-p>', vim.cmd.DiffviewOpen)
		vim.keymap.set('n', '<C-o>', vim.cmd.DiffviewClose)
	end,
}
