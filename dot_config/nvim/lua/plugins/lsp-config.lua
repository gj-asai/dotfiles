return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "lewis6991/hover.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "ruff",
                "julials",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,
            },
        })
        require("hover").setup({
            init = function()
                require("hover.providers.lsp")
                require('hover.providers.diagnostic')
            end,
            preview_opts = {
                border = 'single'
            },
        })

        -- to create the environment:
        -- julia --project=@nvim-lspconfig julia-install-lsp.jl
        require("lspconfig").julials.setup({
            cmd = {
                "julia",
                "--project=@nvim-lspconfig",
                "--sysimage="
                .. vim.fn.system({ "julia", "--startup-file=no", "-q", "-e", "print(homedir())" })
                .. "/.julia/environments/nvim-lspconfig/languageserver.so",
                "--sysimage-native-code=yes",
                "--startup-file=no",
                "--history-file=no",
                vim.fn.stdpath("config") .. "/julia/julials.jl",
                vim.fn.expand("%:p:h"),
            },
            on_attach = function(client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            end,
            settings = {
                julia = {
                    symbolCacheDownload = true,
                    lint = {
                        missingrefs = "all",
                        iter = true,
                        lazy = true,
                        modname = true,
                    },
                },
            },
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        vim.keymap.set("n", "K", require("hover").hover, {})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            underline = false,
            signs = true,
            update_in_insert = false,
        })
    end,
}
