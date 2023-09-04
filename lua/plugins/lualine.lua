-- In your init.lua

require("lualine").setup({
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
--     lualine_w = {
--       {
--         lazy_status.updates,
--         cond = lazy_status.has_updates,
--         color = { fg = "#ff9e64" },
--       },
--     },
    lualine_x = {
      "filetype",
    },
    lualine_y = {
      "progress",
    },
    lualine_z = {     -- Show LCD
      function()
        return vim.fn.getcwd()
      end,
    },
  },
})
