return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp"
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
                    require("lspconfig")[server_name].setup({ })
                end,
            },
        })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

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
                vim.fn.stdpath("config") .. "lua/plugins/lsp/julia/julials.jl",
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
        })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "Show references" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Code format" })
    end,
}
