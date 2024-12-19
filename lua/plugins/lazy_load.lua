-- Setup the plugin manager "Lazy"
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
  { "vimwiki/vimwiki" },                       -- Vimwiki


  -- General plugins
  { import = "plugins.obsidian" }, -- obsidian note taker
  { import = "plugins.treesitter" },
  -- 	{ import = "plugins.lint" },      -- Linter(s)
  { import = "plugins.git" },             -- git related plugins
  { import = "plugins.render-markdown" }, -- Better Terminal display of markdown
  { import = "plugins.terminal" },        -- Toggle Terminal window
  -- 	{ import = "plugins.markdown-preview" }, -- Instant Markdown for neovim


  -- UI based plugins
  { import = "plugins.ui.colorscheme" }, -- ColorScheme
  { import = "plugins.ui.dressing" },    -- Allows prompts and selections
  { import = "plugins.ui.lualine" },     -- Status Line
  { import = "plugins.ui.mini" },        -- Collections on notes, todo's
  { import = "plugins.ui.nvimtree" },    -- NvimTree
  { import = "plugins.ui.telescope" },   -- Fuzzy file finder and many other things
  { import = "plugins.ui.todo" },        -- Todo notes etc
  { import = "plugins.ui.noice" },       --  System messages popup window
  { import = "plugins.ui.conform" },     -- Formatting, linting
  --  { import = "plugins.ui.ufo" },         -- Modern folding
  --	{ import = "plugins.ui.fzf-lua" }, -- Formatting, linting


  -- AI based plugins
  { import = "plugins.ai.gp" }, -- Configure AI prompt
  -- 	{ import = "plugins.ai.ai" }, -- Configure AI prompt
  -- 	{ import = "plugins.ai.copilot" }, -- Configure AI prompt


  -- LSP / Autocompletion language Plugins
  { import = "plugins.lsp.mason" },      -- LSP installer : NOTE THIS HAS TO BE THE FIRST LSP FILE TO LOAD!!!
  { import = "plugins.lsp.none-ls" },    -- null-ls replacement
  { import = "plugins.lsp.nvim-cmp" },   -- Auto Completion
  { import = "plugins.lsp.debug" },      -- LSP Debug
  { import = "plugins.lsp.lsp_config" }, -- LSP configuration

  -- DAP Debugging code base
  -- { "mfussenegger/nvim-dap" },
  -- { "jbyuki/one-small-step-for-vimkind" },

})
