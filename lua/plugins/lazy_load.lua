-- OK first setup the plugin manager "Lazy"load
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
  --  { "instant-markdown/vim-instant-markdown" },     -- Instant Markdown
  --  { "vimwiki/vimwiki" },                           -- Vimwiki
  --  { "MeanderingProgrammer/render-markdown.nvim" }, -- ADDED/MOVED HERE: Ensure render-markdown is a top-level plugin
  -- { import = "plugins.kiwi" },         --# vimwiki alternative
  { import = "plugins.neowiki" },      --# vimwiki alternative
  { "nvim-telescope/telescope.nvim" }, -- ADDED HERE: Ensure Telescope is loaded early as a top-level plugin

  -- { import = "plugins.obsidian" },                 -- obsidian note taker
  { import = "plugins.treesitter" },
  --  { import = "plugins.arduino" },  -- Arduino front end
  --  { import = "plugins.lint" },      -- Linter(s)

  { import = "plugins.git" },      -- git related plugins
  { import = "plugins.terminal" }, -- Toggle Terminal window

  -- UI based plugins
  { import = "plugins.ui.colorscheme" }, -- ColorScheme
  { import = "plugins.ui.dressing" },    -- Allows prompts and selections
  { import = "plugins.ui.lualine" },     -- Status Line
  -- { import = "plugins.ui.mini" },        -- Collections on notes, todo's
  { import = "plugins.ui.telescope" },   -- Fuzzy file finder and many other things
  -- { import = "plugins.ui.todo" },        -- Todo notes etc
  { import = "plugins.ui.conform" },     -- Formatting, linting
  --  { import = "plugins.ui.fzf-lua" }, -- Formatting, linting

  -- AI based plugins
  --  { import = "plugins.ai.mcphub" }, -- Configure AI prompt
  { import = "plugins.ai.copilot" }, -- Configure AI prompt
  -- { import = "plugins.ai.avante" },                   -- AI frontend
  -- { import = "plugins.ai.opencode" }, -- AI frontend
  -- { import = "plugins.ai.llm",        lazy = false }, -- ai litellm

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
