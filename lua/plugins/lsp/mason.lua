local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local lspconfig = require("lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    })

    local on_attach = function(client, bufnr)
      if client.server_capabilities.completionProvider then
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
      end

      local buf_set_keymap = vim.api.nvim_buf_set_keymap
      local opts = { noremap = true, silent = true }

      buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts) -- Consider using this for imported types
      buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

      if client.name == 'ruff_lsp' then
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.definitionProvider = false
      end
    end

    mason_lspconfig.setup({
      ensure_installed = {
        "ansiblels",
        "bashls",
        "groovyls",
        "lua_ls",
        "pyright",
        "ruff",
      },
      automatic_installation = true,
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
          })
        end,

        pyright = function()
          lspconfig.pyright.setup({
            on_attach = on_attach,
            settings = {
              python = {
                analysis = {
                  -- *** START NEW/MODIFIED CONFIG FOR PYTHON PATH ***
                  -- 1. Automatic Search (often works for venv in project root)
                  autoSearchPaths = true,
                  -- 2. Explicit Path (uncomment and set if auto-search fails or for specific setups)
                  -- For venv: pythonPath = vim.fn.getcwd() .. '/.venv/bin/python',
                  -- For poetry: pythonPath = vim.fn.stdpath('data') .. '/mason/bin/python', -- if you installed poetry through Mason
                  -- Or directly to your poetry environment's python if known
                  -- pythonPath = 'path/to/your/poetry/env/python',
                  -- Or a global python if you don't use venvs often
                  -- pythonPath = '/usr/bin/python3',

                  useLibraryCodeForTypes = true, -- Crucial for navigating into installed packages
                  diagnosticMode = "workspace",  -- Recommended for comprehensive diagnostics
                  typeCheckingMode = "basic",    -- Or "strict" for more rigorous checks
                  -- *** END NEW/MODIFIED CONFIG FOR PYTHON PATH ***
                },
              },
            },
          })
        end,

        ruff_lsp = function()
          lspconfig.ruff.setup({
            on_attach = on_attach,
            init_options = {
              settings = {
              },
            },
          })
        end,
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "beautysh",
        "prettier",
        "shellcheck",
        "stylua",
      },
    })
  end,
}

return M
