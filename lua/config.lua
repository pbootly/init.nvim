-- Oil for file management
require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["q"] = "actions.close",
  },
})

-- Keymaps and terminal
vim.keymap.set("n", "-", vim.cmd.Oil)
vim.keymap.set("n", "<leader>|", function()
  vim.cmd("vs")
end)

vim.keymap.set("n", "<leader>-", function()
  vim.cmd("sp")
end)

require("toggleterm").setup({
  size = function()
    return math.floor(vim.o.lines * 0.5)
  end,
  on_open = function(term)
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = term.bufnr })
  end,
})
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("ToggleTerm")
end)

-- clipboard to system
vim.opt.clipboard = "unnamedplus"

-- colorscheme and general settings
vim.cmd("colorscheme tempus_spring")
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

-- esc close quickfix
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    vim.keymap.set("n", "<Esc>", "<cmd>cclose<CR>", {
      buffer = ev.buf,
      silent = true,
      desc = "Close quickfix",
    })
  end,
})

-- diagnostics
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    border = "rounded",
  })
end, { desc = "Show diagnostics" })

-- Next diagnostic
vim.keymap.set("n", "<leader>dn", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

-- Previous diagnostic
vim.keymap.set("n", "<leader>dp", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- lsp
-- lazy like keybinds
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local opts = { buffer = ev.buf, nowait = true }

    if client:supports_method("textDocument/definition") then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Goto Definition" }))
    end

    if client:supports_method("textDocument/references") then
      vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
    end

    if client:supports_method("textDocument/implementation") then
      vim.keymap.set(
        "n",
        "gI",
        vim.lsp.buf.implementation,
        vim.tbl_extend("force", opts, { desc = "Goto Implementation" })
      )
    end

    if client:supports_method("textDocument/typeDefinition") then
      vim.keymap.set(
        "n",
        "gy",
        vim.lsp.buf.type_definition,
        vim.tbl_extend("force", opts, { desc = "Goto Type Definition" })
      )
    end

    if client:supports_method("textDocument/declaration") then
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Goto Declaration" }))
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))

    if client:supports_method("textDocument/signatureHelp") then
      vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature Help" }))
    end
  end,
})
