require('lspsaga').setup({})

vim.keymap.set('n', '<C-Space>', '<cmd>Lspsaga code_action <CR>')
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc')
