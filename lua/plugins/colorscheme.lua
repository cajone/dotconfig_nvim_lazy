
M = {
  "folke/tokyonight.nvim",
  init = function()
    vim.cmd([[colorscheme tokyonight]])
  end,
  config = function()
    local tokyonight = require("tokyonight")
    tokyonight.setup({
      lazy = false,
      priority = 1000,
      style = 'night',
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      opts = {
      },
    })
  end,

} return M

