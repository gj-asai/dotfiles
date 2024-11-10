return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    opts = {},
    cmd = "Trouble",
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", },
        { "<leader>xt", "<CMD>Trouble todo<CR>" },
    }
}
