return {
	{
		"nanotee/zoxide.vim",
		config = function()
			vim.cmd("noremap :cd :Z")
		end,
	},
	{
		"jvgrootveld/telescope-zoxide",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					zoxide = { prompt_title = "zoxide" },
				},
			})
			require("telescope").load_extension("zoxide")
			vim.keymap.set("n", "<leader>cd", ":Telescope zoxide list theme=dropdown previewer=false<CR>")
		end,
	},
}
