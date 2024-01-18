return {
  {
    "mason-org/mason-registry",
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
}
