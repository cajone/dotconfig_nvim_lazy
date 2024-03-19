return {
  configs = require('nvim-treesitter.configs').setup {
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    require('nvim-treesitter.configs').setup{
      ensure_installed = { 'bash', 'groovy', 'json', 'python', 'ruby', 'sql', 'typescript' },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      increamental_selection = {
        enable = false,
      },
      indent = { enable = true, },
      query_linter = true,
    },
  }
}
