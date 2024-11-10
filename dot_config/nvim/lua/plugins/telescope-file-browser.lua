return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("telescope").load_extension("file_browser")
		vim.keymap.set("n", "<leader>fb", require("telescope").extensions.file_browser.file_browser)
	end,
}
