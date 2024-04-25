
M = {
  "folke/tokyonight.nvim",
--  "cajone/cajone-nvim",
  lazy = false,
  priority = 1000,
  opts = {},

  init = function()
    vim.cmd([[colorscheme tokyonight]])
  end,
} return M


-- Other color schemes under consideration
--  "rainglow/vim",
--  "rafi/awesome-vim-colorschemes",
--  "StarryLeo/starry-vim-colorschemes",
--  "jacoborus/tender.vim",
--  "olivercederborg/poimandres.nvim",

-- gotham
-- lunaperche
-- iceberg
-- jellybeans
