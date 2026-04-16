require('vim._core.ui2').enable()

local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("gbprod/nord.nvim"),
    gh("nvim-lualine/lualine.nvim"),
    gh("stevearc/oil.nvim"),
    gh("benomahony/oil-git.nvim"),
    gh("lewis6991/gitsigns.nvim"),
    gh("tpope/vim-fugitive"),
    gh("tpope/vim-surround"),
    gh("folke/todo-comments.nvim"),
    { src = gh("theprimeagen/harpoon"),                        version = "harpoon2" },
    { src = gh("nvim-treesitter/nvim-treesitter"),             version = "main" },
    { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
    gh("nvim-treesitter/nvim-treesitter-context"),
    gh("nvim-telescope/telescope.nvim"),
    { src = gh("saghen/blink.cmp"), version = "v1" },
    gh("neovim/nvim-lspconfig"),
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
})

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
