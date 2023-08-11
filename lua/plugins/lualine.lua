require("lualine").setup({
  options = {
    icon_enabled = true,
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
