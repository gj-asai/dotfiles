return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    layout_config = {
                        preview_width = 0.6,
                        width = 0.98,
                        height = 0.98,
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                    },
                },
            })

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>gp", builtin.git_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = { "make" },
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "jvgrootveld/telescope-zoxide",
        config = function()
            require("telescope").setup({
                extensions = { ["zoxide"] = { prompt_title = "zoxide" } },
            })
            require("telescope").load_extension("zoxide")
            vim.keymap.set("n", "<leader>cd", function()
                require("telescope").extensions.zoxide.list({
                    layout_config = {
                        preview_width = 0,
                        width = 0.6,
                        height = 0.8,
                    },
                })
            end)
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
            require("telescope").load_extension("file_browser")
            vim.keymap.set("n", "<leader>fb", function()
                require("telescope").extensions.file_browser.file_browser({
                    layout_config = { preview_width = 0.4 },
                })
            end)
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        config = function()
            require("telescope").load_extension("lazygit")
            vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>")
        end,
    },
    -- not working with kitty
    -- {
    --     "nvim-telescope/telescope-media-files.nvim",
    --     config = function()
    --         require("telescope").setup({
    --             extensions = {
    --                 ["media_files"] = {
    --                     filetypes = { "png", "jpg", "jpeg", "pdf" },
    --                     find_cmd = "rg",
    --                 },
    --             },
    --         })
    --         require("telescope").load_extension("media_files")
    --         vim.keymap.set("n", "<leader>fm", require("telescope").extensions.media_files.media_files)
    --     end,
    -- },
}
