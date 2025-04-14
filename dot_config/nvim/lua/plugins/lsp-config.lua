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
                    require("lspconfig")[server_name].setup({
                        capabilities = require("blink.cmp").get_lsp_capabilities()
                    })
                end,
            },
        })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

        vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
        vim.diagnostic.config({ virtual_text = true })

        -- to create the environment: lsp/config/julia/makefile
        require("lspconfig").julials.setup({
            on_new_config = function(new_config, _)
                local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
                if require("lspconfig").util.path.is_file(julia) then
                    new_config.cmd[1] = julia
                end
            end,
            root_dir = function(fname)
                local util = require("lspconfig.util")
                return util.root_pattern "Project.toml" (fname) or util.find_git_ancestor(fname) or
                    util.path.dirname(fname)
            end,
        })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "Show references" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Code format" })
    end,
}
