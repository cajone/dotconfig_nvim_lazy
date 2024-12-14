-- Lualine Setup
M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true }
  },
  config = function()
    local lualine = require("lualine")
    lualine.setup({
      options = {
        theme = 'nord',
        icon_enabled = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      },
      sections = {
        lualine_a = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_b = {
          "branch",
          "diff",
          "diagnostics"
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "filetype" },
        lualine_z = {
          function()
            return vim.fn.getcwd()
          end,
          function()
            return os.date("%H:%M")
          end,
        },
      },
    })
  end,
}
return M
