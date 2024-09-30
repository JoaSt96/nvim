return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                svelte = {"prettierd", "prettier"},
                astro = { { "prettierd", "prettier", stop_after_first = true } },
                javascript = { { "prettierd", "prettier", stop_after_first = false } },
                typescript = { { "prettierd", "prettier", stop_after_first = false } },
                javascriptreact = { { "prettierd", "prettier", stop_after_first = false } },
                typescriptreact =  { "prettierd", "prettier" },
                json = { { "prettierd", "prettier", stop_after_first = true } },
                graphql = { { "prettierd", "prettier", stop_after_first = true } },
                html = { "htmlbeautifier" },
                css = { { "prettierd", "prettier", stop_after_first = true } },
                scss = { { "prettierd", "prettier", stop_after_first = true } },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>l", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
