-- Git Gutter like plugin

return {
  { "nvim-lua/plenary.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
}
