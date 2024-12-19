return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("todo-comments").setup()

        local todo_comments = require("todo-comments")
        vim.keymap.set("n", "]t", todo_comments.jump_next, { desc = "Next todo" })
        vim.keymap.set("n", "[t", todo_comments.jump_prev, { desc = "Previous todo" })
        vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>", { desc = "Search todos" })
    end
}

