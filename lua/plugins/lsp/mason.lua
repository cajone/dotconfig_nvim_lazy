M = {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    -- import mason-tools
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

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "groovyls", -- lsp
        --        "isort", -- python formatter
        --        "black", -- python formatter
        --        "pylint", -- python linter
        "eslint_d", -- js linter
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        --        "groovyls",
        --        "pylsp",
        --        "bashls",
      },
      -- auto-install configured servers ( with lspconfig )
      automatic_installation = true, -- not the same as ensure_installed
    })
  end,
}

return M
