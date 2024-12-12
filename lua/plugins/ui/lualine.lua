-- Lualine Setup
M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")
    lualine.setup({
      options = {
        theme = 'nord',
        icon_enabled = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
        --  component_separators = { left = "|", right = "|" },
        --  section_separators = { left = "|", right = "|" },
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
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = {
          "filetype",
        },
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
