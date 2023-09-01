local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.preset('recommended')

lsp.ensure_installed({
	'tsserver',
	'eslint',
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	}
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	lsp.buffer_autoformat()
end)

local cmp = require('cmp')
lsp.defaults.cmp_mappings({
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', '<Tab>', '<S-Tab>')
end)

lsp.setup()

-- confirm completion with enter
cmp.setup({
	mapping = {
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	}
})
