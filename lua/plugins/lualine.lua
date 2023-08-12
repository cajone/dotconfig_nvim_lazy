require("lualine").setup({
  options = {
    icon_enabled = false,
    component_seperators = { left = '|', right = '|' },
    section_seperators = { left = '|', right = '|' },
    theme = "jellybeans",
  },
  sections = {
    lualine_a = {
      {
        "filename",
        path = 1,
      },
    },
  },
})
