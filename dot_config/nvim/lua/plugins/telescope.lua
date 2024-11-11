return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "3rd/image.nvim",
        },
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    layout_config = {
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
                pickers = {
                    find_files = {
                        file_ignore_patterns = { "%.jpg", "%.jpeg", "%.png", "%.pdf" },
                        layout_config = { preview_width = 0.6 },
                    },
                    git_status = {
                        layout_config = { preview_width = 0.6 },
                    },
                    git_files = {
                        layout_config = { preview_width = 0.6 },
                    },
                },
            })

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>gp", builtin.git_files, {})
            vim.keymap.set("n", "<leader>gt", builtin.git_status, {})
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
}
