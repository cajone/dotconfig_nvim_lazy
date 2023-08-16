
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
  { require("plugins.mason") },

  -- Prettier format 
--  { require("plugins.prettier") },

  -- LSP & Language parser syntax highlighting
  { require("plugins.nvim_lspconfig") },

  -- TreeSitter  Language Parsers
  { require("plugins.treesitter") },

  -- Toggle Terminal window
  { require("plugins.terminal") },

  -- Fuzzy file finder and many other things
  { require("plugins.telescope") },

  { "tpope/vim-fugitive", },                                    -- Fugitive ( Git)
  { "nvim-lualine/lualine.nvim", },                             -- Status Bar
  { "vimwiki/vimwiki", },                                       -- Vimwiki
  { "cohama/agit.vim", },                                   -- Git history Tree

}) -- End of Lazy Plugin install section 


  function set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  end

  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
--  local Terminal = require("toggleterm.terminal").Terminal
--  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

