M = {
  -- linting
  { "mfussenegger/nvim-lint",
      opts = {
        event = { "BufReadPre", "BufNewFile" },

      --      json = { "jsonlint" },
      ansible = { "ansible_lint" },
      bash = { "shellcheck" },
      markdown = { "markdownlint" },
      ruby = { "ruby" },
},
},
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
return M
