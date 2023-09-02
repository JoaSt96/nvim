local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.git_files, {})
vim.keymap.set('n', '<leader>t', function()
		builtin.grep_string({ sertrch = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n','<leader>st',builtin.live_grep,{})

