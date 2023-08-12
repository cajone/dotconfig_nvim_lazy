-- Disable perl requirements
vim.g.loaded_perl_provider = 0

-- OK first setup the plugin manager "Lazy"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE although not explicitly stated all the below paths are actually in the lua subtree ie ./lua/plugins/lazy_load
-- Load Plugins
require("plugins.lazy_load")
require("plugins.lualine")



-- NOTE although not explicitly stated all the below paths are actually in the lua subtree ie ./lua/custom directory
-- Custom Setup
require("custom.opts")      -- Load opts
require("custom.keys")      -- Load Keymaps
require("custom.local_fun") -- Load Local Functions
