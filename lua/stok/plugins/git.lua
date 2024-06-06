return {
	'dinhhuy258/git.nvim',
	config = function()
		require('git').setup()
		vim.keymap.set('n', '<leader>gb', vim.cmd.GitBlame)
	end
}
