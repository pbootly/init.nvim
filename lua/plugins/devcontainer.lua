return {
  {
    "esensar/nvim-dev-container",
    config = function()
      require("devcontainer").setup({
        attach_mounts = {
          always = true,
          neovim_config = { enabled = true },
          neovim_data = { enabled = true },
          custom_mounts = {}
        },
        log_level = "info",
      })
      vim.keymap.set('n', '<leader>ds', ':DevcontainerStart<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>da', ':DevcontainerAttach<CR>', { noremap = true, silent = true })
    end
  }
}

