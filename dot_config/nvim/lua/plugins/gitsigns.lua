return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        require("gitsigns").setup()

        -- Navigation
        vim.keymap.set("n", "]h", function()
            gitsigns.nav_hunk("next")
        end, { desc = "Next hunk" })

        vim.keymap.set("n", "[h", function()
            gitsigns.nav_hunk("prev")
        end, { desc = "Previous hunk" })

        -- Actions
        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
        vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
        vim.keymap.set("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk" })
        vim.keymap.set("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk" })
        vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
        vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff hunk" })

        -- Text object
        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
    end,
}
