return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                theme = "nord",
                disabled_filetypes = { 'neo-tree' },
            },
        })
    end,
}
