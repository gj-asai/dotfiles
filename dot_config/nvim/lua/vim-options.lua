vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.cmd("set scrolloff=8")
vim.cmd("set ch=0")

vim.cmd("set nu")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")

vim.cmd("set nohlsearch")
vim.cmd("set incsearch")

vim.cmd("set autoindent")
vim.cmd("set smartindent")

vim.g.mapleader = " "

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function ()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Q', 'q', {})
