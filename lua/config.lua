require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["q"] = "actions.close",
  },
})

vim.keymap.set("n", "-", vim.cmd.Oil)
vim.keymap.set("n", "<leader>|", function()
  vim.cmd("vs")
end)

vim.keymap.set("n", "<leader>-", function()
  vim.cmd("sp")
end)

require("toggleterm").setup()
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("ToggleTerm")
end)

vim.cmd("colorscheme citruszest")
vim.opt.colorcolumn = "80"
vim.opt.relativenumber = true

-- snacks picker
if not package.loaded["snacks"] then
  require("snacks").setup({
    input = { enabled = true },
    -- File related QOLs
    bigfile = { enabled = true },
    quickfile = { enabled = true },

    -- Picker
    picker = {
      layout = {
        preset = "ivy",
      },
      icons = {
        files = {
          enabled = false,
        },
      },
    },
  })
end

local f = require("snacks.picker")
vim.keymap.set("n", "<leader><leader>", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs > 2 then
    f.buffers()
  else
    vim.cmd.bnext()
  end
end)
vim.keymap.set("n", "<leader>ff", function()
  f.files()
end)
vim.keymap.set("n", "<leader>fg", function()
  f.grep()
end)
vim.keymap.set("n", "<leader>fh", function()
  f.command_history()
end)
