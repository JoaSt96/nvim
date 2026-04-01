return {
	"echasnovski/mini.files",
	keys = {
		{ "<leader>ee", function() require("mini.files").open() end, desc = "Open file explorer" },
	},
	opts = {
		mappings = {
			go_in = "l",
			go_out = "h",
		},
	},
	config = function(_, opts)
		local mini_files = require("mini.files")
		mini_files.setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				vim.keymap.set("n", "<CR>", function()
					local entry = mini_files.get_fs_entry()
					if entry and entry.fs_type == "file" then
						mini_files.close()
						vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
					else
						mini_files.go_in()
					end
				end, { buffer = args.data.buf_id, desc = "Open file and close explorer" })
			end,
		})
	end,
}
