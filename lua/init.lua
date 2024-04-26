-- This loads lua/plugins/init.lua and lua/custom/inti.lua, which in turn then load subdiretory init.lua files till the whole tree is loaded

require("plugins")
require("plugins.lsp")
require("custom")
