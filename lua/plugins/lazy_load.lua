
-- Using this Plugin manager start loading plugins using setup()
require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

  -- ColorScheme
  {
    "rafi/awesome-vim-colorschemes",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme jellybeans]])
    end,
	},

  -- Git Signs
  { "nvim-lua/plenary.nvim", },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- NvimTree
  { "kyazdani42/nvim-web-devicons", },   -- filesystem icons,
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- Mason install and manage LSP servers, DAP servers, linters, and formatters.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Language parser syntax highlighting
  {
    'prettier/vim-prettier', -- Will only parse { Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML } 
    run = 'npm install',
    ft = { 'markdown', 'yaml' },
    cmd = { 'Prettier', 'PrettierAsync' },
  },

  {  "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.rubocop.setup{}                   -- Will parse / process Ruby files
      lspconfig.lua_ls.setup{                     -- Will parse lua files
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'},
            },
          },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
      opts= {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = { enable = true, },
        query_linter = true,
      },
  },


  -- Toggle Terminal window
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      size = 20,
      direction = "horizontal",
      hide_numbers = true,
      shading_factor = 2,
      shade_filetypes = {},
      start_in_insert = true,
      insert_mapping = true,
      persistent_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
    },
  },


  -- Fuzzy file finder and many other things
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
      dependencies = { 'nvim-lua/plenary.nvim' },
  },


  { "tpope/vim-fugitive", },                                    -- Fugitive ( Git)

  -- Status Bar
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup()
    end,
  },

  {
    "vimwiki/vimwiki",                                          -- Vimwiki
  },
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
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })



