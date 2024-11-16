M = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        bash = { "beautysh" },
        css = { "prettier" },
        graphql = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier", "eslint_d" }, -- Use eslint_d as a fallback if prettier fails
        javascriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua", { args = { "--indent-type", "space", "--indent-width", "2" } } }, -- Custom Stylua arguments
        markdown = { "prettier" },
        sh = { "beautysh" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
        zsh = { "beautysh" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })

    -- Key mappings
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })

    -- Additional key mapping for partial formatting
    vim.keymap.set("v", "<leader>mf", function()
      conform.format({ async = false, timeout_ms = 500 })
    end, { desc = "Format selection" })
  end,
}
return M
