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
  checker = {                                     -- turns off notificactions
    enable = true,
    notify = false,
  },
  change_detection = { notify = false, },         -- Stop reporting auto changes

  { "nvim-treesitter/nvim-treesitter" },          -- Install Treesitter
  { "hrsh7th/nvim-cmp" },                         -- Neo Complete
  { import = "plugins.colorscheme" },             -- ColorScheme
  { import = "plugins.dressing" },                -- Allows prompts and selections
  { import = "plugins.git-worktree" },            -- Treesitter git-worktree
  { import = "plugins.gitsigns" },                -- Git Signs
  { import = "plugins.lualine" },                 -- Status Line
  { import = "plugins.mason" },                   -- LSP installer
  { import = "plugins.nvim_lspconfig" },          -- LSP & Language parser syntax highlighting
  { import = "plugins.nvimtree" },                -- NvimTree
  { import = "plugins.telescope" },               -- Fuzzy file finder and many other things
  { import = "plugins.terminal" },                -- Toggle Terminal window
  { import = "plugins.nvim-treesitter" },         -- Configure TreeSitter  Language Parsers
  { import = "plugins.ai" },                      -- Configure AI prompt
  { import = "plugins.indent-blankline" },        -- Visually show indentation
--  { import = "plugins.which-key" },               -- which-key.nvim
--  { import = "plugins.auto-session" },            -- Auto save restore sessions 

--  { import = "plugins.distant" } ,                -- ssh connections
--  { import = "plugins.nvim-cmp" },                -- Auto Completion

--  { "TabbyML/vim-tabby" },                        -- Co Pilot Alternative
  { "sindrets/diffview.nvim", },                  -- gitdiff view
  { "b0o/schemastore.nvim" },                     -- Language parser(s)
  { "tpope/vim-fugitive", },                      -- Fugitive ( Git)
  { "tpope/vim-dadbod", },                        -- DB interaction
  { "kristijanhusak/vim-dadbod-completion", },    -- DB autocompletion
  { "kristijanhusak/vim-dadbod-ui", },            -- UI for the above
  { "tpope/vim-rhubarb", },                       -- Git Support
  { "vimwiki/vimwiki", },                         -- Vimwiki
  { "instant-markdown/vim-instant-markdown", },   -- Instant Markdown
  { "mzlogin/vim-markdown-toc", },                -- Markdown TOC
--  { "cohama/agit.vim", },                         -- Git history Tree
  { "NLKNguyen/papercolor-theme", },              -- Alternative colorschemes
})
