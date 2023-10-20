return {
  { "nvim-tree/nvim-web-devicons", }, -- filesystem icons,
  {
    "nvim-tree/nvim-tree.lua",  -- Some comment
    config = function()
      require("nvim-tree").setup()
      require("dressing").setup()
    end,
  },
}
