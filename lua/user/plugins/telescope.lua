return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev results
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["<leader>ff"] = builtin.find_files,
            { desc = "Fuzzy find files in cwd" },
            ["<leader>fr"] = builtin.oldfiles,
            { desc = "List recently opened files" },
            ["<leader>fg"] = builtin.live_grep,
            { desc = "Find string in cwd" },
            ["<leader>fc"] = builtin.grep_string,
            { desc = "Find string under cursor" },
            ["<leader>fb"] = builtin.buffers,
            { desc = "Show currently opend buffers" },
            ["<leader>fh"] = builtin.help_tags,
            { desc = "Open help pages" },
          },
        },
      },
    })
    telescope.load_extension("fzf")
  end,
}
