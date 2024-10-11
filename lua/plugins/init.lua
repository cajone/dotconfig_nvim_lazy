-- Init the plugins

-- Disable perl requirements
vim.g.loaded_perl_provider = 0

-- Setup for vimwiki, if I dont put this here it does not load the markdown, must find a way to fix this
vim.g.vimwiki_list = {
  {
    path = "~/vimwiki/", -- Change this to the path where you want to keep your wiki files
    syntax = "markdown",
    ext = ".md",
    link_format = "fg=blue",
  },
}

require("plugins.lazy_load")
require('render-markdown').setup({
    file_types = { 'markdown', 'vimwiki' },
})
vim.treesitter.language.register('markdown', 'vimwiki')
