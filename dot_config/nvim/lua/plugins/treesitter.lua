local languages = {
    "cmake", "cpp", "css", "csv", "dockerfile", "html", "html", "javascript", "julia", "python", "toml"
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter').install(languages)

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('treesitter.setup', {}),
                callback = function(args)
                    local buf = args.buf
                    local filetype = args.match

                    -- you need some mechanism to avoid running on buffers that do not
                    -- correspond to a language (like oil.nvim buffers), this implementation
                    -- checks if a parser exists for the current language
                    local language = vim.treesitter.language.get_lang(filetype) or filetype
                    if not vim.treesitter.language.add(language) then
                        return
                    end

                    -- replicate `highlight = { enable = true }`
                    vim.treesitter.start(buf, language)

                    -- replicate `indent = { enable = true }`
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts
            vim.g.no_plugin_maps = true
        end,
        config = function()
            local select = require("nvim-treesitter-textobjects.select").select_textobject

            vim.keymap.set({ "x", "o" }, "am", function()
                select("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "im", function()
                select("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "aa", function()
                select("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ia", function()
                select("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "l=", function()
                select("@assignment.lhs", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "r=", function()
                select("@assignment.rhs", "textobjects")
            end)

            -- expand selection
            vim.keymap.set("n", "<C-space>", "van", { remap = true })
            vim.keymap.set({ "x", "o" }, "<C-space>", "an", { remap = true })

            -- shrink selection
            vim.keymap.set({ "x", "o" }, "<BS>", "in", { remap = true })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true })
        end,
    },
}
