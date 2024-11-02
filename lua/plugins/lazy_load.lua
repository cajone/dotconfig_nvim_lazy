-- OK first setup the plugin manager "Lazy"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  checker = { -- turns off notifications
    enable = true,
    notify = false,
  },
  change_detection = { notify = false }, -- Stop reporting auto changes

  -- Plugins used straight out the box
  { "instant-markdown/vim-instant-markdown" }, -- Instant Markdown
  { "vimwiki/vimwiki" }, -- Vimwiki

  { import = "plugins.lint" }, -- Linter(s)

  -- Plugins that have some localisation done to them
  { import = "plugins.ai" }, -- Configure AI prompt
  --  { import = "plugins.gp" }, -- Configure AI prompt
  { import = "plugins.git" }, -- git related plugins
  { import = "plugins.markdown-preview" }, -- Instant Markdown for neovim
  { import = "plugins.render-markdown" }, -- Better Terminal display of markdown
  { import = "plugins.terminal" }, -- Toggle Terminal window

  -- ssh remote
  --  { import = "plugins.remote" }, -- remote ssh

  -- UI based plugins
  { import = "plugins.ui.colorscheme" }, -- ColorScheme
  { import = "plugins.ui.dressing" }, -- Allows prompts and selections
  { import = "plugins.ui.lualine" }, -- Status Line
  { import = "plugins.ui.mini" }, -- Collections on notes, todo's
  { import = "plugins.ui.nvimtree" }, -- NvimTree
  { import = "plugins.ui.telescope" }, -- Fuzzy file finder and many other things
  { import = "plugins.ui.todo" }, -- Todo notes etc
  { import = "plugins.ui.noice" }, --  System messages

  -- Linting
  { import = "plugins.conform" }, -- Formatting, linting

  -- LSP / Auto completion language Plugins
  { import = "plugins.lsp.mason" }, -- LSP installer
  { import = "plugins.lsp.none-ls" }, -- null-ls replacement
  --  { import = "plugins.lsp.nvim-cmp" }, -- Auto Completion
  --  { import = "plugins.lsp.debug" }, -- LSP Debug
  --  { import = "plugins.lsp.lsp_config" }, -- LSP configuration

  -- DAP Debugging code base
  --  { "mfussenegger/nvim-dap" },
  --  { "jbyuki/one-small-step-for-vimkind" },
})
