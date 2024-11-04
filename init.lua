-- Change the <LEADER> Key
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- xdg issue
vim.g.vim_execute_system_list = true
vim.opt.cpo = 'cmap'

-- Start loading the contents of lua/init.lua
require("init")
