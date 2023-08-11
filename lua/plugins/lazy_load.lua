
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

  -- Fugitive ( Git)
  {
    "tpope/vim-fugitive",
  },

  -- Vimwiki
  {
    "vimwiki/vimwiki",
    config = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki/", -- Change this to the path where you want to keep your wiki files
          syntax = "markdown",
          ext = ".md",
        },
      }
    end,
  },
})
