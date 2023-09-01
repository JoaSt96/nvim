require('onedark').setup {
	style = 'darker',
	transparent = false,
	term_colors = true,
	lualine = {
		transparent = true, -- lualine center bar transparency
	},
}

vim.cmd.colorscheme('onedark')

vim.keymap.set('n', '<leader>bn', vim.cmd.bnext)
vim.keymap.set('n', '<leader>bb', vim.cmd.bprev)
