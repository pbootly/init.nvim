vim.pack.add({
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/mikavilpas/blink-ripgrep.nvim",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/stevearc/conform.nvim",
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("^1") },
  "https://github.com/akinsho/toggleterm.nvim",
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config")
