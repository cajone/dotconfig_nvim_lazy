M = {
  "ldelossa/gh.nvim",
  dependencies = {
    "ldelossa/litee.nvim",
  },
  config = function()
    require("litee.lib").setup()
    require("litee.gh").setup()
  end,
}
return M
