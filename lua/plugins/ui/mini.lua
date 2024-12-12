M = {
  -- Highlight todo, notes, etc in comments
  "folke/todo-comments.nvim",
  -- enabled = false,
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = false },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })

      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
}
return M
