local M = {
  { "kyazdani42/nvim-web-devicons", }, -- filesystem icons,
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },
}
return M
