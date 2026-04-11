require('vim._core.ui2').enable()

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/gbprod/nord.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/benomahony/oil-git.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/tpope/vim-surround",
    "https://github.com/folke/todo-comments.nvim",
    { src = "https://github.com/theprimeagen/harpoon",                        version = "harpoon2" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-telescope/telescope.nvim",
    -- "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/saghen/blink.cmp", version = "v1" },
    "https://github.com/neovim/nvim-lspconfig",
})

require("vim-options")
require("remaps")

require("nord").setup()
vim.cmd.colorscheme("nord")

require("lualine").setup({
    options = {
        theme = "nord",
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
            'filetype',
            'lsp_status'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})

require("oil").setup()
require("todo-comments").setup()
require("gitsigns").setup()
require("harpoon"):setup()

require('nvim-treesitter').install({
    "cmake", "cpp", "css", "csv", "dockerfile", "html", "html", "javascript", "julia", "python", "toml"
})
vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Autoupdate parsers when package updates",
    group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true }),
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        end
    end
})
vim.api.nvim_create_autocmd("FileType", {
    desc = "Autostart treesitter parser",
    group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true }),
    callback = function(args)
        local buf = args.buf
        local filetype = args.match
        local language = vim.treesitter.language.get_lang(filetype) or filetype

        -- check if a parser exists for the current language
        if not vim.treesitter.language.add(language) then
            return
        end

        vim.treesitter.start(buf, language)
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require("telescope").setup({
    defaults = {
        layout_config = {
            width = 0.98,
            height = 0.98,
            horizontal = { preview_width = 0.6 },
        },
        mappings = {
            i = {
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
        },
    },
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
    },
})
-- require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

require("blink.cmp").setup({
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
    },
    snippets = { preset = 'luasnip' },
    sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
    },
    completion = {
        documentation = {
            auto_show = true,
            window = { border = 'rounded' },
        },
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = false } },
        menu = {
            draw = {
                columns = { { 'label', 'label_description', gap = 1 }, { "kind" } },
            }
        }
    },
    signature = {
        enabled = true,
        window = { border = 'rounded' },
    },
})

vim.lsp.enable("clangd")  -- requires clangd
vim.lsp.enable("julials") -- requires @nvim-lspconfig environment
vim.lsp.enable("lua_ls")  -- requires lua-language-server
vim.lsp.enable("ruff")    -- requires ruff
vim.lsp.enable("ty")      -- requires ty

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
    virtual_text = true,
    severity_sort = true,
})
