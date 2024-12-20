M = {
  -- Fugitive
  {
    "tpope/vim-fugitive",
    opts = {}
  }, -- Fugitive ( Git)
  {
    "tpope/vim-rhubarb",
    opts = {}
  }, -- Git Support
  {
    "cohama/agit.vim",
    opts = {}
  }, -- Git history Tree

  -- Git Diffview
  {
    "sindrets/diffview.nvim",
    opts = {}
  }, -- gitdiff view
  {
    "nvim-lua/plenary.nvim",
    opts = {}
  },

  -- GitSigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup()
    end,
  },
}
return M
