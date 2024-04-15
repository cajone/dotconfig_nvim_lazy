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
  checker = {                                     -- turns off notifications
    enable = true,
    notify = false,
  },
  change_detection = { notify = false, },         -- Stop reporting auto changes

  -- Plugins used straight out the box
  { "b0o/schemastore.nvim" },                     -- Language parser(s)
  { "instant-markdown/vim-instant-markdown", },   -- Instant Markdown
  { "vimwiki/vimwiki", },                         -- Vimwiki

  -- Plugins that have some localisation done to them
  { import = "plugins.ai" },                      -- Configure AI prompt
  { import = "plugins.colorscheme" },             -- ColorScheme
  { import = "plugins.db" },                      -- Database related plugins
  { import = "plugins.dressing" },                -- Allows prompts and selections
  { import = "plugins.git" },                     -- git related plugins
  { import = "plugins.indent-blankline" },        -- Visually show indentation
  { import = "plugins.lualine" },                 -- Status Line
  { import = "plugins.markdown-preview" },        -- Instant Markdown for neovim
  { import = "plugins.nvim-cmp" },                -- Auto Completion
  { import = "plugins.nvimtree" },                -- NvimTree
  { import = "plugins.none-ls" },                 -- null-ls replacement
  { import = "plugins.telescope" },               -- Fuzzy file finder and many other things
  { import = "plugins.terminal" },                -- Toggle Terminal window

  -- LSP Plugins
--  { import = "plugins.lsp.mason" },               -- LSP installer
--  { import = "plugins.lsp.lsp_config" },          -- LSP configuration

  -- Plugins being tested
--  { import = "plugins.which-key" },               -- which-key.nvim
--  { import = "plugins.auto-session" },            -- Auto save restore sessions 
--  { import = "plugins.distant" } ,                -- ssh connections
})
