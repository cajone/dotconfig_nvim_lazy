M = {
  "nvimtools/none-ls.nvim",
  event = "LazyFile",
  dependencies = { "mason.nvim" },
  optional = true,
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = opts.sources
      or {
        nls.builtins.formatting.stylua, -- lua formating
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.luacheck, -- lua linting
        --        null_ls.builtins.diagnostics.eslint_d,
        --        null_ls.builtins.diagnostics.rubocop,
        --        null_ls.builtins.formatting.rubocop,
      }
    vim.keymap.set("n", "<leader>nf", vim.lsp.buf.format, {})
  end,
}
return M
