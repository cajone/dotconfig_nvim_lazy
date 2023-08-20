local M = {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, },
    query_linter = true,
  },
}
return M
