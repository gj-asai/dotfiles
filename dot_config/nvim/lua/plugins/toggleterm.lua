return {
    "akinsho/toggleterm.nvim",
    config = function ()
        require("toggleterm").setup({
            open_mapping = [[<a-'>]],
            direction = "float",
            float_opts = {
                width = 130,
                height = 23,
                border = "curved",
            },
        })
    end,
}
