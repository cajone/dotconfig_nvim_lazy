-- Using this Plugin manager start loading plugins using setup()
require("lazy").setup({
  {
    "folke/which-key.nvim",
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim",

    { import = "plugins.colorscheme" },     -- ColorScheme
    { import = "plugins.gitsigns" },        -- Git Signs
    { import = "plugins.nvimtree" },        -- NvimTree
    { import = "plugins.nvim_lspconfig" },  -- LSP & Language parser syntax highlighting
    { import = "plugins.treesitter" },      -- TreeSitter  Language Parsers
    { import = "plugins.terminal" },        -- Toggle Terminal window
    { import = "plugins.telescope" },       -- Fuzzy file finder and many other things

    --   {                                  -- Requires you setup API keys with jenkins server
    --     "ckipp01/nvim-jenkinsfile-linter",
    --     requires = { "nvim-lua/plenary.nvim" },
    --   },

  --  { "dense-analysis/ale", },                          -- Linter plugin
    { "tpope/vim-fugitive", },                          -- Fugitive ( Git)
    { "nvim-lualine/lualine.nvim", },                   -- Status Bar
    { "vimwiki/vimwiki", },                             -- Vimwiki
    { "instant-markdown/vim-instant-markdown", },       -- Instant Markdown
    { "mzlogin/vim-markdown-toc", },                    -- Markdown TOC
    { "cohama/agit.vim", },                             -- Git history Tree

    -- Mason install and manage LSP servers, DAP servers, linters, and formatters.
    -- { import = "plugins.mason" },

    -- Prettier format
    -- { import = "plugins.prettier" },

    -- Linter
    --  { import = "dense-analysis/ale" },
  },

}) -- End of Lazy Plugin install section

-- vim.g.ale_linters = {
--   ruby = { 'cookstyle -a' },
-- }
-- vim.cmd('autocmd! TermOpen term://* lua Set_terminal_keymaps()')
--  local Terminal = require("toggleterm.terminal").Terminal
--  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
