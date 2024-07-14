return {
	"nanotee/zoxide.vim",
	config = function()
		vim.cmd("noremap :cd :Z")
	end,
}
