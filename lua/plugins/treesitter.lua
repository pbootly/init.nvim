return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = { "rust", "jsonc", "go", "c", "lua", "vim", "vimdoc", "query" },
			auto_install = true,
		})
	end
}
