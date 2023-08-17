local M = {
"neovim/nvim-lspconfig",
 config = function()
    local lspconfig = require('lspconfig')
    local luaformatter = {
      formatcommand = "lua-format -i" ,
      formatStdin = true,
    }
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
        languages = {
          lua = { luaformatter },
        },
      },
    }
    lspconfig.groovyls.setup{
      cmd = { vim.fn.expand('~/.local/share/nvim/mason/packages/groovy-language-server/groovy-language-server')},
    }
  end,
} return M
