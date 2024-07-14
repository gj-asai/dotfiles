return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    dependencies = {
	"nvim-treesitter/nvim-treesitter-context",
    },
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "julia", "python" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
