vim.pack.add({
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/mbbill/undotree",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/zootedb0t/citruszest.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/moyiz/blink-emoji.nvim",
	"https://github.com/mikavilpas/blink-ripgrep.nvim",
	"https://github.com/L3MON4D3/LuaSnip",
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("^1") },
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config")
require("keymaps")
