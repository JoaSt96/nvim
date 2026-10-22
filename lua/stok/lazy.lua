local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local function run_git(args, action, cleanup_path)
	local output = vim.fn.system(args)
	if vim.v.shell_error ~= 0 then
		local cleanup_error = ""
		if cleanup_path and vim.loop.fs_stat(cleanup_path) then
			vim.fn.delete(cleanup_path, "rf")
			if vim.loop.fs_stat(cleanup_path) then
				cleanup_error = ("; failed to remove partial clone at %s"):format(cleanup_path)
			end
		end
		error(("Failed to %s: %s%s"):format(action, vim.trim(output), cleanup_error))
	end
end

local function locked_lazy_commit()
	local lockfile = io.open(vim.fn.stdpath("config") .. "/lazy-lock.json", "r")
	if not lockfile then
		return nil
	end

	local contents = lockfile:read("*a")
	lockfile:close()

	local decoded, lock = pcall(vim.json.decode, contents)
	if not decoded or type(lock) ~= "table" then
		return nil
	end

	local entry = lock["lazy.nvim"]
	local commit = type(entry) == "table" and entry.commit or nil
	if type(commit) ~= "string" or not commit:match("^%x+$") or (#commit ~= 40 and #commit ~= 64) then
		return nil
	end

	return commit
end

if not vim.loop.fs_stat(lazypath) then
	run_git({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}, "clone lazy.nvim", lazypath)

	local commit = locked_lazy_commit()
	if commit then
		run_git(
			{ "git", "-C", lazypath, "checkout", "--detach", commit },
			"checkout locked lazy.nvim commit",
			lazypath
		)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "stok.plugins" }, { import = "stok.plugins.lsp" } }, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
