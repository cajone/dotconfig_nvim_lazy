M = {
  configs = require('nvim-treesitter.configs').setup {
    require('nvim-treesitter.configs').setup{
      ensure_installed = {
--        'bash',
        'groovy',
        'lua',
        'python',
        'ruby',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      increamental_selection = {
        enable = true,
      },
      indent = { enable = true, },
      query_linter = true,
    },
  }
} return M
