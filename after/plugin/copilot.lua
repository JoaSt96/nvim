-- copilot remap accept
vim.api.nvim_set_keymap('i', '<C-u>', 'copilot#Accept("<CR>")',{expr=true,silent=true})

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
