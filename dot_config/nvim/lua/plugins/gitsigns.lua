return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        require("gitsigns").setup()

        -- Navigation
        vim.keymap.set("n", "]h", function()
            gitsigns.nav_hunk("next")
        end)

        vim.keymap.set("n", "[h", function()
            gitsigns.nav_hunk("prev")
        end)

        -- Actions
        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
        vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
        vim.keymap.set("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        vim.keymap.set("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer)
        vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk)
        vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer)
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
        vim.keymap.set("n", "<leader>hd", gitsigns.diffthis)

        -- Text object
        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
}
