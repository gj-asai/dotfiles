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
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "List LSP symbols" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>gp", builtin.git_files, { desc = "Git files" })
            vim.keymap.set("n", "<leader>gt", builtin.git_status, { desc = "Git status" })
            vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Show references" })
            vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Show definitions" })
            vim.keymap.set("n", "<leader>xd", builtin.diagnostics, { desc = "Show diagnostics" })
            vim.keymap.set("n", "<leader>xx", function()
                builtin.diagnostics({ bufnr = 0 })
            end, { desc = "Show diagnostics current buffer" })
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
