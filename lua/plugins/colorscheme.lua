M = {
--  "rainglow/vim",
--  "rafi/awesome-vim-colorschemes",
  "tonsky/neovim-colors.git",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme gotham]])
  end,
} return M

-- gotham
-- lunaperche
-- iceberg
-- jellybeans
