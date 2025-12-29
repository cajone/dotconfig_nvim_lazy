local M = {
  -- Fugitive: The "Action" tool
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs",  ":Git<CR>",                                        desc = "Git Status" },
      { "<leader>gp",  ":Git push<CR>",                                   desc = "Git Push" },
      -- CHANGED: Moved Blame to <leader>gm (m for blaMe) to free up 'b'
      { "<leader>gm",  ":Git blame<CR>",                                  desc = "Git Blame" },
      { "<leader>gls", ':G log --pretty=format:"%h - %an, %ar : %s"<CR>', desc = "Short Git Log" },
    },
  },
  { "tpope/vim-rhubarb" },

  -- Telescope Git: The "Picker" tools (Moved from keys.lua to here)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- FIXED: 'b' is now strictly for Branches
      {
        "<leader>gb",
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>gc",
        function()
          require("telescope.builtin").git_commits()
        end,
        desc = "Git Commits",
      },
    },
  },

  -- Agit: The "History Explorer"
  {
    "cohama/agit.vim",
    keys = {
      { "<leader>gl", ":Agit<CR>",     desc = "Agit Log Tree" },
      { "<leader>gh", ":AgitFile<CR>", desc = "Agit File History" },
    },
    init = function()
      vim.g.agit_reuse_tab = 1
      vim.g.agit_max_log_lines = 1000
    end,
  },

  -- Diffview & Gitsigns (kept as before...)
  { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
}

return M
