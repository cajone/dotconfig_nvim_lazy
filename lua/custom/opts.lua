-- opts.lua

-- Override Filetype-Specific Indentation Settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.bo.tabstop = 2      -- Set tabstop to 2 for Lua files
    vim.bo.shiftwidth = 2   -- Set shiftwidth to 2 for Lua files
    vim.bo.softtabstop = 2  -- Set softtabstop to 2 for Lua files, needed for consistent behavior
    vim.bo.expandtab = true -- Ensure that spaces are used instead of tabs for indentation in Lua files
  end,
})

local opt = vim.opt
local g = vim.g

-- g.makeprg = 'ansible- lint'

-- Sync clipboard between OS and Neovim.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
opt.clipboard = "unnamedplus"

-- Define which version of Python to use
g.python3_host_prog = "/usr/bin/python3"

-- [[ Instant Markdown ]]
g.instant_markdown_slow = 2
g.instant_markdown_autostart = 0

-- [[ NvimTree ]]
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- [[ Context ]]
-- opt.colorcolumn = "120" -- str: Show column for max line length
opt.number = true         -- bool: Show line numbers
opt.relativenumber = true -- bool: Show relative line numbers
opt.scrolloff = 4         -- int: Min num lines of context
opt.signcolumn = "yes"    -- str: Show the sign column
opt.scrolljump = 5        -- Lines to scroll when cursor leaves screen

-- [[ Filetypes ]]
opt.encoding = "utf8" -- str: String encoding to use

-- [[ Theme ]]
opt.syntax = "ON"        -- str: Allow syntax highlighting
opt.termguicolors = true -- bool: If term supports UI color then enable

-- [[ Search ]]
opt.ignorecase = true -- bool: Ignore case in search patterns
opt.smartcase = true  -- bool: Override ignorecase if search contains capitals
opt.incsearch = true  -- bool: Use incremental search
opt.hlsearch = true   -- bool: Highlight search matches
opt.showmatch = true  -- bool: Show matching brackets/parenthesis

-- [[ Whitespace ]]
opt.expandtab = true -- bool: Use spaces instead of tabs
opt.shiftwidth = 2   -- num: Size of an indent
opt.softtabstop = 2  -- num: Number of spaces tabs count for in insert mode
opt.tabstop = 2      -- num: Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true -- bool: Place new window to the right of current one
opt.splitbelow = true -- bool: Place new window below the current one

-- [[ Maintain undo history between sessions :echo g:undodir ]]
opt.undofile = true                -- Allow undo history to be kept
g.undodir = "~/.config/nvim/undo/" -- Where to keep the undo history
opt.viminfo:append({ "n" })        -- Remember cursor position between sessions
opt.swapfile = false               -- Don't generate a swap file

-- [[ Ctrl-n menu options ]]
opt.wildmenu = true                -- Show list instead of just completing
opt.wildmode = "list:longest,full" -- Command <Tab> completion, list matches, then longest common part, then all.
opt.whichwrap = "b,s,h,l,<,>,[,]"  -- Backspace and cursor keys wrap too

-- [[ Change the default shell out to /usr/bin/bash ]]
opt.shell = "/usr/bin/bash" -- Change the :! shell to use bash
