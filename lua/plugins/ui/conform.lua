M = {
  "stevearc/conform.nvim",
  -- enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      ansible = { "ansible_lint" },
      bash = { "beautysh" },
      css = { "prettier" },
      graphql = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier", "eslint_d" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      lua = { "stylua", { args = { "--indent-type", "space", "--indent-width", "2" } } },
      markdown = { "prettier" },
      sh = { "beautysh" },
      svelte = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      yaml = { "prettier" },
      zsh = { "beautysh" },
      format_on_save = {
        lsp_fallback = true,
        async = true,
        timeout_ms = 500,
      },
    })

    -- Custom formatter configuration if needed
    -- conform.formatters.stylua.args["--config-path"] = "~/.config/stylua.toml" -- Example custom Stylua config path

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      local status, err = pcall(function()
        conform.format({
          lsp_fallback = true,
          async = true,
          timeout_ms = 500,
        })
      end)
      if not status then
        print("Formatter error: ", err)
      end
    end, { desc = "Format file or range (in visual mode)" })

    vim.keymap.set("v", "<leader>mf", function()
      local status, err = pcall(function()
        conform.format({
          async = true,
          timeout_ms = 500,
        })
      end)
      if not status then
        print("Formatter error: ", err)
      end
    end, { desc = "Format selection" })
  end,
}

return M
