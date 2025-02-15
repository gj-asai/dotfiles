return {
    {
        "windwp/nvim-autopairs",
        config = true,
    },
    {
        'L3MON4D3/LuaSnip',
        config = function()
            require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
        end
    },
    {
        'saghen/blink.cmp',
        version = 'v0.*',
        opts = {
            keymap = {
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },
                ['<C-y>'] = { 'fallback' }, -- unbind
                ['<Tab>'] = { 'select_and_accept', 'fallback' },

                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-j>'] = { 'snippet_forward', 'fallback' },
                ['<C-k>'] = { 'snippet_backward', 'fallback' },

                ['<C-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
                ['<C-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
                ['<C-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
                ['<C-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
                ['<C-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
                ['<C-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
                ['<C-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
                ['<C-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
                ['<C-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
                ['<C-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
            },
            snippets = { preset = 'luasnip' },
            sources = {
                default = function()
                    if vim.bo.filetype == 'tex' then
                        return { 'snippets', 'lsp', 'path' }
                    else
                        return { 'snippets', 'lsp', 'path', 'buffer' }
                    end
                end,
                cmdline = {},
            },
            enabled = function()
                -- return not vim.tbl_contains({ "tex" }, vim.bo.filetype)
                --     and vim.bo.buftype ~= "prompt"
                --     and vim.b.completion ~= false
                return vim.bo.buftype ~= 'prompt'
                    and vim.b.completion ~= false
            end,
            completion = {
                keyword = { range = 'full' },
                accept = { auto_brackets = { enabled = true } },
                menu = {
                    draw = {
                        columns = { { 'item_idx' }, { 'label', 'label_description', gap = 1 }, { "kind" } },
                        components = { item_idx = { text = function(ctx) return tostring(ctx.idx) end, } },
                    }
                }
            },
            signature = {
                enabled = true,
                window = { border = 'rounded' },
            },
        }
    },
}
