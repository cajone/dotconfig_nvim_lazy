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
  defaults = {
    lazy = false,
    version = false,
  },

  change_detection = { notify = false }, -- Stop reporting auto changes

  -- Plugins used straight out the box
  { "instant-markdown/vim-instant-markdown" }, -- Instant Markdown
  { "vimwiki/vimwiki" },                      -- Vimwiki

  { import = "plugins.obsidian" }, -- obsidian note taker
  { import = "plugins.treesitter" },
  -- 	{ import = "plugins.lint" },      -- Linter(s)

  { import = "plugins.git" },     -- git related plugins
  { import = "plugins.terminal" }, -- Toggle Terminal window

  -- UI based plugins
  { import = "plugins.ui.colorscheme" }, -- ColorScheme
  { import = "plugins.ui.dressing" }, -- Allows prompts and selections
  { import = "plugins.ui.lualine" },    -- Status Line
  { import = "plugins.ui.nvimtree" },   -- NvimTree
  { import = "plugins.ui.telescope" },  -- Fuzzy file finder and many other things
  { import = "plugins.ui.fzf-lua" }, -- Fuzzy Finding

})
