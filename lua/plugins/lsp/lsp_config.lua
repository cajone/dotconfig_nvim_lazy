M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },

  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- conciseness

    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definitions, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", "vim.lsp.buf.declaration", opts) -- go to declaration

      opts.desc = "Show LSP definition"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show definitions, references

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions 

      opts.desc = "See availible code actions"
      keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts) -- See availible code actions

      opts.desc = "Smart Rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file 

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostics.open_float, opts) -- show diagnostics for line

      opts.desc = "Goto previous diagnostic"
      keymap.set("n", "[d", vim.diagnostics.goto_prev, opts) -- Jump to previous in buffer 

      opts.desc = "Goto next diagnostic"
      keymap.set("n", "]d", vim.diagnostics.goto_next, opts) -- Jump to next in buffer 

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- LSP Restart
    end

    -- used to enable autocompletion ( assign to every lsp server config )
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- configure lua server
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- configure groovy server
    lspconfig["groovyls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure bash server
    lspconfig["bashls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure python server
    lspconfig["pylsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure ansible server
    lspconfig["ansiblels"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })





  end,
} return M
