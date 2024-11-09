return {
    "akinsho/toggleterm.nvim",
    config = function ()
        require("toggleterm").setup({
            open_mapping = [[<a-'>]],
            direction = "float",
            float_opts = {
                border = "curved",
            },
        })
    end,
}
