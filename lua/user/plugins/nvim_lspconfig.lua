return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local luaformatter = {
      formatcommand = "lua-format -i",
      formatStdin = true,
    }
    lspconfig.lua_ls.setup({ -- Will parse lua files
      cmd = { "lua-language-server" },
      settings = {
        Lua = { -- this really should be set to 'lua' but is causing an issue with vim global
          cmd = { "luacheck" },
          diagnostics = {
            enable = true,
            globals = { "vim" },
          },
        },
        languages = {
          lua = { luaformatter },
        },
      },
    })
  end,
}
