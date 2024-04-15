M = {
  { "tpope/vim-fugitive", },                      -- Fugitive ( Git)
  { "tpope/vim-rhubarb", },                       -- Git Support

  -- Git Diffview
  { "sindrets/diffview.nvim", },                  -- gitdiff view
  { "nvim-lua/plenary.nvim", },

  -- GitSigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup()
    end,
  },

  -- Git Worktrees
  "ThePrimeagen/git-worktree.nvim",
  config = function()
    require("git-worktree").setup()
    require("telescope").load_extension("git_worktree")
  end
} return M
