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
        theme = "tokoyonight",
        icon_enabled = true,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '|', right = '|' },
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
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = {
          "progress",
          "|",
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
} return M
