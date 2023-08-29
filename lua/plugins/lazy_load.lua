-- Using this Plugin manager start loading plugins using setup()
require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

  -- ColorScheme
  { require("plugins.colorscheme") },

  -- Git Signs
  { require("plugins.gitsigns") },

  -- NvimTree
  { require("plugins.nvimtree") },

  -- Mason install and manage LSP servers, DAP servers, linters, and formatters.
  -- { require("plugins.mason") },

  -- Prettier format
  -- { require("plugins.prettier") },

  -- LSP & Language parser syntax highlighting
  { require("plugins.nvim_lspconfig") },

  -- TreeSitter  Language Parsers
  { require("plugins.treesitter") },

  -- Linter
--  { require("dense-analysis/ale") },

  -- Toggle Terminal window
  { require("plugins.terminal") },

  -- Fuzzy file finder and many other things
  { require("plugins.telescope") },

  --   {                                                          -- Requires you setup API keys with jenkins server
  --     "ckipp01/nvim-jenkinsfile-linter",
  --     requires = { "nvim-lua/plenary.nvim" },
  --   },

  { "tpope/vim-fugitive", },                          -- Fugitive ( Git)
  { "nvim-lualine/lualine.nvim", },                   -- Status Bar
  { "vimwiki/vimwiki", },                             -- Vimwiki
  { "instant-markdown/vim-instant-markdown", },       -- Instant Markdown
  { "mzlogin/vim-markdown-toc", },                    -- Markdown TOC
  { "cohama/agit.vim", },                             -- Git history Tree

}) -- End of Lazy Plugin install section


-- vim.cmd('autocmd! TermOpen term://* lua Set_terminal_keymaps()')
--  local Terminal = require("toggleterm.terminal").Terminal
--  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
