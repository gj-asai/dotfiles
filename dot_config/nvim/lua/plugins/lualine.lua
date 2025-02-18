return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                theme = "nord",
                disabled_filetypes = { 'neo-tree' },
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_x = {
                    function()
                        if vim.fn.reg_recording() ~= '' then
                            return 'Recording @' .. vim.fn.reg_recording()
                        else
                            return ''
                        end
                    end,
                    'filetype'
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        })
    end,
}
