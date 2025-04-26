vim.lsp.enable({
    'luals',
    'julials',
})

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.diagnostic.config({ virtual_text = true })

vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover({
        border = "rounded",
    })
end, { desc = "Show hover" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Code format" })
