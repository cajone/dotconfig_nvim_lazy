-- [[ opts.lua ]]

local opt = vim.opt
local cmd = vim.cmd

--[[ LEADER ]]
-- vim.g.mapleader = "\\"
vim.g.localleader = "\\"

-- [[ Context ]]
-- opt.colorcolumn = '120'           -- str:  Show col for max line length
opt.number = true         -- bool: Show line numbers
opt.relativenumber = true -- bool: Show relative line numbers
opt.scrolloff = 4         -- int:  Min num lines of context
opt.signcolumn = "yes"    -- str:  Show the sign column
opt.scrolljump = 5        -- Lines to scroll when cursor leaves screen

-- [[ Filetypes ]]
opt.encoding = "utf8"     -- str:  String encoding to use
opt.fileencoding = "utf8" -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"        -- str:  Allow syntax highlighting
opt.termguicolors = true -- bool: If term supports ui color then enable
cmd("highlight LineNr guifg=#48558f")
cmd("highlight LineNr guibg=#1e2132")
cmd("highlight SignColumn guibg=#1e2132")

-- [[ Search ]]
opt.ignorecase = true -- bool: Ignore case in search patterns
opt.smartcase = true  -- bool: Override ignorecase if search contains capitals
opt.incsearch = true  -- bool: Use incremental search
opt.hlsearch = true   -- bool: Highlight search matches
opt.showmatch = true  -- Show matching brackets/parenthesis

-- [[ Whitespace ]]
opt.expandtab = true -- bool: Use spaces instead of tabs
opt.shiftwidth = 2   -- num:  Size of an indent
opt.softtabstop = 2  -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 2      -- num:  Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true -- bool: Place new window to right of current one
opt.splitbelow = true -- bool: Place new window below the current one

-- [[ Maintain undo history between sessions :echo g:undodir ]]
opt.undofile = true                    -- Allow undo history to be kept
vim.g.undodir = "~/.config/nvim/undo/" -- Where to keep the undo history
opt.viminfo:append({'n'})              -- Remember cursor position between sessions

-- [[ Ctrl-n menu options ]]
opt.wildmenu = true                -- Show list instead of just completing
opt.wildmode = "list:longest,full" -- Command <Tab> completion, list matches, then longest common part, then all.
opt.whichwrap = "b,s,h,l,<,>,[,]"  -- Backspace and cursor keys wrap too

-- [[ Change the default shell out to /usr/bin/zsh ]]
opt.shell = "/usr/bin/zsh" -- Change the :! shell to use zsh

