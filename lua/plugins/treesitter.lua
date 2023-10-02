return {
  "nvim-treesitter/nvim-treesitter",
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'bash', 'python', 'ruby', 'sql' },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    increamental_selection = {
      enable = true,
    },
    indent = { enable = true, },
    query_linter = true,
  }
}
