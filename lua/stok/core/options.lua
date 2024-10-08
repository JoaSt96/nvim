vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.g.mapleader = " "
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- make cursor always a block cursor in all modes
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor"
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.api.nvim_set_option("clipboard", "unnamed")
vim.opt.termguicolors = true
