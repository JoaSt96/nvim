require('lspsaga').setup({})

vim.keymap.set('n', '<C-k>', '<cmd>Lspsaga diagnostic_jump_next <CR>')
vim.keymap.set('n', '<C-j>', '<cmd>Lspsaga diagnostic_jump_prev <CR>')
vim.keymap.set('n', '<C-Space>','<cmd>Lspsaga code_action <CR>')

