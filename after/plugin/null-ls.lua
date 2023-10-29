local null_ls = require('null-ls')
local eslint = require('lspconfig').eslint
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

eslint.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})


-- TODO: figure out how to wire up ember-template-lint
local lsp_formatting = function(buffer)
    vim.lsp.buf.format({
        filter = function(client)
            -- By default, ignore any formatters provider by other LSPs
            -- (such as those managed via lspconfig or mason)
            -- Also "eslint as a formatter" doesn't work :(
            return client.name == "null-ls"
        end,
        bufnr = buffer,
    })
end

-- Format on save
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
local on_attach = function(client, buffer)
    -- the Buffer will be null in buffers like nvim-tree or new unsaved files
    if (not buffer) then
        return
    end

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = buffer,
            callback = function()
                lsp_formatting(buffer)
            end,
        })
    end
end

null_ls.setup({
    sources = {
        -- Prettier, but faster (daemonized)
        null_ls.builtins.formatting.prettierd.with({
            filetypes = {
                "css", "json", "jsonc", "javascript", "typescript",
            }
        }),
        null_ls.builtins.formatting.black.with({
            filetypes = {
                "python"
            }
        }),
        -- Code actions for staging hunks, blame, etc
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.completion.luasnip,

    },
    on_attach = on_attach
})

--[[ null_ls.setup({
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.diagnostics.eslint,
	null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.eslint_d,

	on_attach = require("lsp-zero").common_on_attach,
	debounce = 150,
	save_after_format = false,
	sources = {
		null_ls.builtins.formatting.prettierd.with {
			condition = function(utils)
				return not utils.root_has_file { ".eslintrc", ".eslintrc.js" }
			end,
			prefer_local = "node_modules/.bin",
		},
		null_ls.builtins.formatting.eslint_d.with {
			condition = function(utils)
				return utils.root_has_file { ".eslintrc", ".eslintrc.js", ".prettierrc" }
			end,
			prefer_local = "node_modules/.bin",
		},
	},

})  ]]
