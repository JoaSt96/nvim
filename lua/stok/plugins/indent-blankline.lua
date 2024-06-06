return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("ibl").setup()
		vim.opt.list = true
	end
}
