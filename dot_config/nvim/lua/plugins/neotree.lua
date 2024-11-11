return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            enable_diagnostics = false,
            enable_git_status = false,
            popup_border_style = "rounded",
            window = {
                mappings = {
                    ["<space>e"] = "close_window",
                    ["Y"] = require("plugins.utils.copy_path"),
                },
            },
            filesystem = {
                follow_current_file = { enabled = true },
                leave_dirs_open = true,
            },
            event_handlers = {
                {
                    event = "file_open_requested",
                    handler = function()
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
            }
        })

        vim.keymap.set("n", "<leader>e", function()
            require("neo-tree.command").execute({ toggle = true })
        end)
        vim.keymap.set("n", "<leader>gs", function()
            require("neo-tree.command").execute({ source = "git_status", position = "float" })
        end)
    end,
}
