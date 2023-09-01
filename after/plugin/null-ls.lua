local null_ls = require('null-ls')

null_ls.setup({
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.diagnostics.eslint,
	null_ls.builtins.completion.spell,

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

})
