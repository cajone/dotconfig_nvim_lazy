local M = {
  'prettier/vim-prettier', -- Will only parse { Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML } 
  config = function()
    local lspconfig = require('lspconfig')
    lspconfig.prettier.setup{
      ft = { 'markdown', 'yaml', 'typescript', 'groovy' },
      cmd = { 'prettierd --no-jsx-bracket-same-line --no-loglevel=error' },
    }
  end,
} return M

