return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                }, {
                    { name = "path" },
                    { name = "buffer" },
                }),
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local ls = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            vim.snippet.active = function(filter)
                filter = filter or {}
                filter.direction = filter.direction or 1

                if filter.direction == 1 then
                    return ls.expand_or_jumpable()
                else
                    return ls.jumpable(filter.direction)
                end
            end

            vim.snippet.jump = function(direction)
                if direction == 1 then
                    if ls.expandable() then
                        return ls.expand_or_jump()
                    else
                        return ls.jumpable(1) and ls.jump(1)
                    end
                else
                    return ls.jumpable(-1) and ls.jump(-1)
                end
            end

            vim.keymap.set({ "i", "s" }, "<c-k>", function()
                return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<c-j>", function()
                return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
            end, { silent = true })
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    }
}
