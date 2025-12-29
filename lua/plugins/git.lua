local M = {
  -- Fugitive: The "Action" tool
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs",  ":Git<CR>",                                        desc = "Git Status" },
      { "<leader>gp",  ":Git push<CR>",                                   desc = "Git Push" },
      { "<leader>gm",  ":Git blame<CR>",                                  desc = "Git Blame" },
      { "<leader>gls", ':G log --pretty=format:"%h - %an, %ar : %s"<CR>', desc = "Short Git Log" },
    },
  },
  { "tpope/vim-rhubarb" },

  -- Telescope Git: The "Picker" tools
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
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

  -- Diffview: The "Review" tool
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",  desc = "Diffview Open" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
  },

  -- GitSigns: The "Gutter/Hunk" tool
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            opts.desc = opts.desc
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation between hunks
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Jump to next git hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Jump to prev git hunk" })

          -- Inline Actions
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk in floating window" })
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage current hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset/Discard current hunk" })
        end,
      })
    end,
  },
}

return M
