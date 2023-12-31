return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim", },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-tree/nvim-web-devicons", },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      use_regex = true, -- Add this line to enable the "use_regex" option
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,  -- move to prev results
            ["<C-j>"] = actions.move_selection_next,      -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          }
        }
      }
    })

    telescope.load_extension("fzf");
  end
}

