return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			options = {
				multiple_diag_under_cursor = true,
				multilines = true,
				show_source = true,
				enable_on_insert = false,
				overflow = { mode = "wrap" },
			},
		})

		-- Disable built-in virtual_text since this plugin replaces it
		vim.diagnostic.config({ virtual_text = false })
	end,
}
