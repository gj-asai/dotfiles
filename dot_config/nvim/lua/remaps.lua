vim.keymap.set({ "n", "v" }, "H", "_")
vim.keymap.set({ "n", "v" }, "L", "$")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")

vim.keymap.set("n", "J", "mZJ`Z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>Y", '"+yg_')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.keymap.set("n", "]p", 'o<Esc>p')
vim.keymap.set("n", "[p", 'O<Esc>p')
vim.keymap.set("n", "<leader>]p", 'o<Esc>"+p')
vim.keymap.set("n", "<leader>[p", 'O<Esc>"+p')

-- remap incremental selection
vim.keymap.set("n", "<C-space>", "van", { remap = true })
vim.keymap.set({ "x", "o" }, "<C-space>", "an", { remap = true })
vim.keymap.set({ "x", "o" }, "<BS>", "in", { remap = true })

-- text objects
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
vim.keymap.set({ "x", "o" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

-- gitsigns
local gitsigns = require("gitsigns")
vim.keymap.set("n", "]h", function() gitsigns.nav_hunk("next") end, { desc = "Next hunk" })
vim.keymap.set("n", "[h", function() gitsigns.nav_hunk("prev") end, { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })

-- harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon quick menu" })
vim.keymap.set("n", "<C-p>", function() harpoon:list():select(1) end, { desc = "Harpoon select 1" })
vim.keymap.set("n", "<C-m>", function() harpoon:list():select(2) end, { desc = "Harpoon select 2" })
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon select 3" })
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(4) end, { desc = "Harpoon select 4" })

-- todo-comments
local todo = require("todo-comments")
vim.keymap.set("n", "]t", todo.jump_next, { desc = "Next todo" })
vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Previous todo" })

-- treesitter-context
vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Jump to context" })

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = "File browser" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader>xx", function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>", { desc = "Search todos" })

-- lsp
vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Show hover" })
vim.keymap.set("n", "grf", vim.lsp.buf.format, { desc = "Code format" })
vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Show references" })
vim.keymap.set("n", "grd", builtin.lsp_definitions, { desc = "Show definitions" })
vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { desc = "List LSP symbols" })
