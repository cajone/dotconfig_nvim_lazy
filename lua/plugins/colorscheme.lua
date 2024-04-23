M = {
-- Other color schemes under consideration
--  "rainglow/vim",
--  "rafi/awesome-vim-colorschemes",
--  "StarryLeo/starry-vim-colorschemes",
  "folke/tokyonight.nvim",
--  "jacoborus/tender.vim",

--  "olivercederborg/poimandres.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
--  config = function()
--    require('jellybeans').setup{
--      bold_vert_split = true,
--      dim_nc_background = true,
--      disable_background = true,
--      disable_float_background = true,
--      disable_italics = true,
--    }
--  end,

  init = function()
    vim.cmd([[colorscheme tokyonight]])
  end,
} return M

-- gotham
-- lunaperche
-- iceberg
-- jellybeans
