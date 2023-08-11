
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

  -- NvimTree
  { "kyazdani42/nvim-web-devicons", },   -- filesystem icons,
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
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

  { "tpope/vim-fugitive", },          -- Fugitive ( Git)

  -- Status Bar
  { "nvim-lualine/lualine.nvim", 
    config = function()
      require("plugins.lualine").setup()
    end,
  },

  -- Vimwiki
  {
    "vimwiki/vimwiki",
  },
})
