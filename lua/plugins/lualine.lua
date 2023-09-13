-- Lualine Setup

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")
    lualine.setup({
      options = {
        icon_enabled = false,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '|', right = '|' },
        theme = "jellybeans",
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
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
          },
        },
        lualine_v = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_w = {
          "filetype",
        },
        lualine_x = {
          "progress",
        },
        lualine_y = {     -- Show LCD
          function()
            return vim.fn.getcwd()
          end,
        },
        lualine_z = {
          function()
            return os.date("%H:%M")
          end,
        },
      },
    })
  end,
}
