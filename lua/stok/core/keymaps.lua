vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.keymap.set("n", "<leader>Q", vim.cmd.qa)

-- mover el texto seleccionado con J y K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- appendear la linea anterior al final
vim.keymap.set("n", "J", "mzJ`z")

-- remap para no perder pegar al borrar o visar lo viejo
vim.keymap.set("v", "p", '"_dP')

--vertical split
vim.keymap.set("n", "<leader>s", vim.cmd.vsplit)
--horizontal split
vim.keymap.set("n", "<leader>h", vim.cmd.split)

local function close_all_splits_optimized()
    local current_win = vim.api.nvim_get_current_win() -- Get the current window only once
    local windows = vim.api.nvim_list_wins()        -- Get the list of all windows

    -- Iterate in reverse to avoid issues with window indexing while closing
    for i = #windows, 1, -1 do
        local win = windows[i]
        if win ~= current_win then
            vim.api.nvim_win_close(win, false) -- Close the window, non-forcefully
        end
    end
end

-- Keymap to close all splits and merge windows into the current one
vim.keymap.set("n", "<leader>v", close_all_splits_optimized)

vim.keymap.set("n", "<leader>c", vim.cmd.bd)

vim.keymap.set("n", "<C-k>", function()
    vim.cmd.wincmd("k")
end)
vim.keymap.set("n", "<C-l>", function()
    vim.cmd.wincmd("l")
end)

vim.keymap.set("n", "<C-h>", function()
    vim.cmd.wincmd("h")
end)

vim.keymap.set("n", "<C-j>", function()
    vim.cmd.wincmd("j")
end)

vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)
vim.keymap.set("n", "<leader>bb", vim.cmd.bprev)
