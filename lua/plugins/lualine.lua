-- Lualine Setup

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")
    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043",
    }
--    local my_lualine_theme = {
--      normal = {
--        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
--        b = { bg = colors.bg, fg = colors.fg },
--        c = { bg = colors.bg, fg = colors.fg },
--      },
--      insert = {
--        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
--        b = { bg = colors.bg, fg = colors.fg },
--        c = { bg = colors.bg, fg = colors.fg },
--      },
--      visual = {
--        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
--        b = { bg = colors.bg, fg = colors.fg },
--        c = { bg = colors.bg, fg = colors.fg },
--      },
--      command = {
--        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
--        b = { bg = colors.bg, fg = colors.fg },
--        c = { bg = colors.bg, fg = colors.fg },
--      },
--    }
    lualine.setup({
      options = {
        theme = "iceberg",
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
}
