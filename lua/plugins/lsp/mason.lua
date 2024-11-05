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
        "ansible-lint", -- ansible linter
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "groovyls", -- lsp
        "ansiblelanguage-server",
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
        "groovyls",
        "ansible-lint",
        "ansible-language-server",
        --        "pylsp",
        --        "bashls",
      },
      -- auto-install configured servers ( with lspconfig )
      automatic_installation = true, -- not the same as ensure_installed
    })
  end,
}

return M
