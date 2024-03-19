return {
  "rafi/awesome-vim-colorschemes",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme jellybeans]])
--     require("colorscheme").setup({
--       jellybeans_overrides = {
--         background = {
--           guibg = "#101000",
--           ctermbg = "yellow",
--         },
--       },
--     })
  end,
}
