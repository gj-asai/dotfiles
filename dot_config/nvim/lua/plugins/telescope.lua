return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>gp", builtin.git_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>nv", function ()
			    builtin.find_files {
                    cwd = "~/.config/nvim",
                }
			end, {})
            vim.keymap.set("n", "<leader>gnv", function ()
			    builtin.live_grep {
                    cwd = "~/.config/nvim",
                }
			end, {})
		end,
	},
	{
		"jvgrootveld/telescope-zoxide",
		config = function()
			local builtin = require("telescope.builtin")
			local z_utils = require("telescope._extensions.zoxide.utils")

			require("telescope").setup({
				extensions = {
					{
						prompt_title = "[ Zoxide List ]",

						-- Zoxide list command with score
						list_command = "zoxide query -ls",
						mappings = {
							default = {
								action = function(selection)
									vim.cmd.edit(selection.path)
								end,
								after_action = function(selection)
									print("Directory changed to " .. selection.path)
								end,
							},
							["<C-s>"] = { action = z_utils.create_basic_command("split") },
							["<C-v>"] = { action = z_utils.create_basic_command("vsplit") },
							["<C-e>"] = { action = z_utils.create_basic_command("edit") },
							["<C-b>"] = {
								keepinsert = true,
								action = function(selection)
									builtin.file_browser({ cwd = selection.path })
								end,
							},
							["<C-f>"] = {
								keepinsert = true,
								action = function(selection)
									builtin.find_files({ cwd = selection.path })
								end,
							},
							["<C-t>"] = {
								action = function(selection)
									vim.cmd.tcd(selection.path)
								end,
							},
						},
					},
				},
			})

			require("telescope").load_extension("zoxide")
            vim.keymap.set("n", "<leader>cd", require("telescope").extensions.zoxide.list)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
