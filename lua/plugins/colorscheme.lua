M = {
  "olivercederborg/poimandres.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('poimandres').setup{}
  end,

  init = function()
    vim.cmd([[colorscheme poimandres]])
  end
} return M


-- Other color schemes under consideration
--  "rainglow/vim",
--  "rafi/awesome-vim-colorschemes",
--  "tonsky/neovim-colors.git",
--  "jacoborus/tender.vim",

-- gotham
-- lunaperche
-- iceberg
-- jellybeans
