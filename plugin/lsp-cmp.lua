require("mason").setup()
local registry = require("mason-registry")
local wanted = {
  "bash-language-server",
  "gofumpt",
  "gopls",
  "lua-language-server",
  "terraform-ls",
  "yamlfix",
  "stylua",
  "ols",
  "rust-analyzer",
  "rustfmt",
  "pyright",
  "black",
  "ansible-language-server",
  "ansible-lint",
  "clangd",
  "clang-format",
  "gdtoolkit",
}
for _, name in ipairs(wanted) do
  local ok, pkg = pcall(registry.get_package, name)
  if ok then
    if not pkg:is_installed() then
      pkg:install()
    end
  else
    vim.notify("Mason package not found: " .. name, vim.log.levels.WARN)
  end
end

vim.lsp.enable(vim.tbl_map(function(f)
  return f:gsub("%.lua$", "")
end, vim.fn.readdir(vim.fn.stdpath("config") .. "/lsp")))

require("luasnip.loaders.from_vscode").lazy_load({
  paths = vim.fn.stdpath("config") .. "/snippets",
})

require("blink.cmp").setup({
  keymap = {
    ["<c-k>"] = { "select_prev", "fallback" },
    ["<up>"] = { "select_prev", "fallback" },
    ["<c-j>"] = { "select_next", "fallback" },
    ["<down>"] = { "select_next", "fallback" },
    ["<cr>"] = {
      "snippet_forward",
      "accept",
      "fallback",
    },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = true,
    },
  },
  sources = {
    default = { "lsp", "snippets", "path", "buffer", "ripgrep" },
    providers = {
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        opts = {},
      },
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})

local c = require("conform")
c.setup({

  formatters_by_ft = {
    go = { "gofumpt" },
    rust = { "rustfmt" },
    lua = { "stylua" },
    terraform = { "terraform_fmt" },
    yaml = { "yamlfix" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    json = { "jq" },
    python = { "black" },
    c = { "clang-format" },
  },
  formatters = {
    yamlfix = {
      env = {
        YAMLFIX_WHITELINES = "1",
        YAMLFIX_COMMENTS_WHITELINES = "1",
        YAMLFIX_LINE_LENGTH = "200",
      },
    },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return nil
    end
    return { timeout_ms = 10000, lsp_fallback = true }
  end,
})

-- Godot DAP
local dap = require("dap")

dap.adapters.godot = function(callback, _)
  callback({
    type = "server",
    host = "127.0.0.1",
    port = 6006, -- must match Godot debug port
  })
end

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Attach to Godot",
    project = "${workspaceFolder}", -- optional, for clarity
  },
}

vim.api.nvim_create_user_command("GodotDebug", function()
  dap.continue()
end, {})

vim.api.nvim_create_user_command("GodotBreakAtCursor", function()
  dap.toggle_breakpoint()
end, {})

vim.api.nvim_create_user_command("GodotStep", function()
  dap.step_over()
end, {})

vim.api.nvim_create_user_command("GodotContinue", function()
  dap.continue()
end, {})

vim.api.nvim_create_user_command("GodotQuit", function()
  dap.terminate()
end, {})
