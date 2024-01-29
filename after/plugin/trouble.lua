
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>tp", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("document_diagnostics") end)

