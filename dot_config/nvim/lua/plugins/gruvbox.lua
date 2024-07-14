return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_foreground = "original"
        vim.g.gruvbox_material_background = "soft"
        vim.g.gruvbox_material_better_performance = 1

        vim.cmd.colorscheme("gruvbox-material")
        vim.cmd([[set termguicolors]])
    end,
}
