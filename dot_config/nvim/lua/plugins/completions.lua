return {
    {
        "windwp/nvim-autopairs",
        config = true,
    },
    {
        'saghen/blink.cmp',
        version = 'v0.*',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        },
        opts = {
            keymap = {
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },
                ['<Tab>'] = { 'select_and_accept', 'fallback' },

                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-j>'] = { 'snippet_forward', 'fallback' },
                ['<C-k>'] = { 'snippet_backward', 'fallback' },

                ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
                ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
                ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
                ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
                ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
                ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
                ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
                ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
                ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
            },
            snippets = {
                expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction) require('luasnip').jump(direction) end,
            },
            sources = {
                completion = {
                    enabled_providers = { 'luasnip', 'lsp', 'path', 'buffer' },
                },
            },
            completion = {
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
