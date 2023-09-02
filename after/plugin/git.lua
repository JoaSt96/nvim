require('git').setup()

vim.keymap.set('n', '<leader>gb',vim.cmd.GitBlame)
