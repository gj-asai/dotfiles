return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<C-p>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-m>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-i>", function() harpoon:list():select(4) end)

        vim.keymap.set("n", "<leader><C-p>", function() harpoon:list():replace_at(1) end)
        vim.keymap.set("n", "<leader><C-m>", function() harpoon:list():replace_at(2) end)
        vim.keymap.set("n", "<leader><C-n>", function() harpoon:list():replace_at(3) end)
        vim.keymap.set("n", "<leader><C-i>", function() harpoon:list():replace_at(4) end)
    end,
}
