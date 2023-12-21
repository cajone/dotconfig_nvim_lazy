return {
  configs = require('nvim-treesitter.configs').setup {
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    require('nvim-treesitter.configs').setup{
--      ensure_installed = { 'bash', 'groovy', 'json', 'python', 'ruby', 'sql', 'typescript' },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      increamental_selection = {
        enable = false,
      },
      indent = { enable = true, },
      query_linter = true,
    },
  }
}
