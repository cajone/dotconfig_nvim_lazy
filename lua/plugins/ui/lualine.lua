-- Lualine Setup
M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true }
  },
  lazy_status = require("lazy.status"),
  opts = {
    options = {
      icon_enabled = true,
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "|", right = "|" },
    },
    sections = {
      lualine_a = { "filename"},
      lualine_b = { "branch" },
      lualine_c = { "diagnostics"},
      lualine_x = { },
      lualine_y = { "progress", "|", "filetype" },
      lualine_z = {
        function()
          return vim.fn.getcwd()
        end,
        function()
          return os.date("%H:%M")
        end,
      },
    },
  }
}
return M
