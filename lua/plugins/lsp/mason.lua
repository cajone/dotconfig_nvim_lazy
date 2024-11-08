M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason") -- Important this must be the first LSP module you load !!
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

<<<<<<< HEAD
||||||| f12f1ec
    mason_tool_installer.setup({
      ensure_installed = {
        "ansible-lint", -- ansible linter
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "groovyls", -- lsp
        "ansiblels",
        --        "isort", -- python formatter
        --        "black", -- python formatter
        --        "pylint", -- python linter
        "eslint_d", -- js linter
      },
    })

=======
    mason_tool_installer.setup({
      ensure_installed = {
        "ansible-lint", -- ansible linter
        "ansiblels",
        "eslint_d", -- js linter
        "groovyls", -- lsp
        "npm-groovy-lint", -- groovy linter
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        --        "black", -- python formatter
        --        "isort", -- python formatter
        --        "pylint", -- python linter
      },
    })

>>>>>>> 7ddfac1604c555c03889980581bec5a9c8bbfc6c
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "ansible-lint",
        "ansiblels",
<<<<<<< HEAD
        "bashls",
        "beautysh", -- shell lsp
        "groovyls",
        "lua_ls",
||||||| f12f1ec
        --        "pylsp",
=======
        "groovyls",
        "lua_ls",
        "npm-groovy-lint", -- groovy linter
>>>>>>> 7ddfac1604c555c03889980581bec5a9c8bbfc6c
        --        "bashls",
        --        "pylsp",
      },
      -- auto-install configured servers ( with lspconfig )
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "ansible-lint", -- ansible linter
        "ansiblels",
        "bashls",
        "beautysh", -- shell lsp
        "eslint_d", -- js linter
        "groovyls", -- lsp
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        --        "black", -- python formatter
        --        "isort", -- python formatter
        --        "pylint", -- python linter
      },
    })
  end,
}

return M
