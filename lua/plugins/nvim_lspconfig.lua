local M = {
"neovim/nvim-lspconfig",
 config = function()
    local lspconfig = require('lspconfig')
    lspconfig.rubocop.setup{}                   -- Will parse / process Ruby files
--     lspconfig.bash.setup{                       -- Will parse shell scripts
--       ft = { 'sh', 'bash' },
--     }
    lspconfig.lua_ls.setup{                     -- Will parse lua files
      cmd = {"lua-language-server"},
      settings = {
        Lua = {
          diagnostics = {
            enable = true,
            globals = {'vim'},
          },
        },
      },
    }
  end,
} return M
