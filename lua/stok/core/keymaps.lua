vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

-- mover el texto seleccionado con J y K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- appendear la linea anterior al final
vim.keymap.set("n", "J", "mzJ`z")

-- remap para no perder pegar al borrar o visar lo viejo
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "Q", "<nop>")

--vertical split
vim.keymap.set("n", "<leader>s", vim.cmd.vsplit)
--horizontal split
vim.keymap.set("n", "<leader>h", vim.cmd.split)

vim.keymap.set("n", "<leader>c", vim.cmd.bd)

vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")

vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)
vim.keymap.set("n", "<leader>bb", vim.cmd.bprev)
