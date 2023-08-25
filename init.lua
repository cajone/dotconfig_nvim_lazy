
-- Change the <LEADER> Key
vim.g.mapleader = '\\'


-- Setup for vimwiki, if I dont put this here it does not load the markdown, must find a way to fix this
vim.g.vimwiki_list = {
  {
    path = "~/vimwiki/", -- Change this to the path where you want to keep your wiki files
    syntax = "markdown",
    ext = ".md",
    link_format = "fg=blue"
  },
}




-- Start loading the contents of lua/inut.lua
require('init')
