require('nvim_comment').setup()

vim.keymap.set('n', '<leader>;', vim.cmd.CommentToggle)
vim.keymap.set('v', '<leader>;', vim.cmd.CommentToggle)
