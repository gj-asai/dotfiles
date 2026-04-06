return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        local actions = require("telescope.actions")
        local fb_actions = require("telescope._extensions.file_browser.actions")

        require("telescope").setup({
            defaults = {
                layout_config = {
                    width = 0.98,
                    height = 0.98,
                    horizontal = {
                        preview_width = 0.6,
                    },
                },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
            },
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
                ["file_browser"] = {
                    hijack_netrw = true,
                    path = "%:p:h",
                    display_stat = false,
                    grouped = true,
                    sorting_strategy = "ascending",
                    initial_mode = "normal",
                    mappings = {
                        ["n"] = {
                            ["q"] = actions.close,
                            ["<BS>"] = fb_actions.goto_parent_dir,
                        },

                    },
                },
            },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("file_browser")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = "File browser" })
        vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "List LSP symbols" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Show references" })
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Show definitions" })
        vim.keymap.set("n", "<leader>xd", builtin.diagnostics, { desc = "Show diagnostics" })
        vim.keymap.set("n", "<leader>xx", function()
            builtin.diagnostics({ bufnr = 0 })
        end, { desc = "Show diagnostics current buffer" })
    end,
}
