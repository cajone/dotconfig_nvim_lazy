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
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        settings = {
          Lua = {
            diagnostics = {
              disable = { "missing-fields" },
              globals = { "vim" },
            },
          },
        },
      }
      vim.lsp.enable("lua_ls")
    end
  }
}
return M
