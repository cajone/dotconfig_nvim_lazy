M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason") -- Important this must be the first LSP module you load !!
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "ansiblels",
        "bashls",
        "groovyls",
        "lua_ls",
      },
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "beautysh",   -- shell lsp
        "prettier",   -- prettier formatter
        "shellcheck", -- bash formatter
        "stylua",     -- lua formatter
      },
    })
  end,
}

return M
