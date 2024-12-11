M = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- Ctrl-x Ctrl-o
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            -- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      require("lspconfig").lua_ls.setup({
        diagnostics = {
          disable = { "missing-fields" },
          -- NOTE Fix this Undefined global vim issue
          globals = { 'vim' },
        },
      })
    end
  }
}
return M
