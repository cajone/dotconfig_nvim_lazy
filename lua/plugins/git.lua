M = {
  {
    "NeogitOrg/neogit",
    dependencies = {
      { "sindrets/diffview.nvim" }, -- gitdiff view
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup {
        disable_commit_confirmation = true,
        intergrations = {
          diffview = true
        }
      }
    end
  },


  -- Fugitive
  --  { "tpope/vim-fugitive" }, -- Fugitive ( Git)
  -- { "tpope/vim-rhubarb" }, -- Git Support
  -- { "cohama/agit.vim" }, -- Git history Tree


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
