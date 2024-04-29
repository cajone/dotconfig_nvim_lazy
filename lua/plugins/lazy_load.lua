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
  --   checker = { -- turns off notifications
  --     enable = true,
  --     notify = false,
  --   },
  change_detection = { notify = false }, -- Stop reporting auto changes

  -- Plugins used straight out the box
  { "instant-markdown/vim-instant-markdown" }, -- Instant Markdown
  { "vimwiki/vimwiki" }, -- Vimwiki

  -- Plugins that have some localisation done to them
  { import = "plugins.ai" }, -- Configure AI prompt
  { import = "plugins.git" }, -- git related plugins
  { import = "plugins.markdown-preview" }, -- Instant Markdown for neovim
  { import = "plugins.terminal" }, -- Toggle Terminal window

  -- UI based plugins
  { import = "plugins.ui.colorscheme" }, -- ColorScheme
  { import = "plugins.ui.dressing" }, -- Allows prompts and selections
  { import = "plugins.ui.lualine" }, -- Status Line
  { import = "plugins.ui.mini" }, -- Collections on notes, todo's
  { import = "plugins.ui.nvimtree" }, -- NvimTree
  { import = "plugins.ui.telescope" }, -- Fuzzy file finder and many other things
  { import = "plugins.ui.todo" }, -- Todo notes etc

  -- Linters 
  { import = "plugins.nvim-cmp" }, -- Auto Completion
  { import = "plugins.lint" }, -- Linter(s)
  { import = "plugins.none-ls" }, -- null-ls replacement

})
