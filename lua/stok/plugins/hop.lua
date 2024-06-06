return {
	"phaazon/hop.nvim",
	config = function()
		require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		-- KEYMAPS
		vim.keymap.set("n", "s", vim.cmd.HopChar2)
		vim.keymap.set("n", "S", vim.cmd.HopWord)
	end,
}
