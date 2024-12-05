M = {
  -- Fugitive
  { "tpope/vim-fugitive" }, -- Fugitive ( Git)
  { "tpope/vim-rhubarb" },  -- Git Support
  { "cohama/agit.vim" },    -- Git history Tree

  -- Git Diffview
  { "sindrets/diffview.nvim" }, -- gitdiff view
  { "nvim-lua/plenary.nvim" },

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
