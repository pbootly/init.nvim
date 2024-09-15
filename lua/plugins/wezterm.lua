return {
  {
    'willothy/wezterm.nvim',
    config = true,
    cond = function()
      return vim.fn.executable("wezterm") == 1 
    end
  }
}

