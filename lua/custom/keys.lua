-- keys.lua: Person keymaps, leader key is '\' by default

local keymap = vim.api.nvim_set_keymap
local set = vim.keymap.set
local builtin = require("telescope.builtin")


-- Jumping between windows replacement for Ctrl-w[hjkl]
keymap("n", "<C-h>", "<C-w>h", { noremap = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- Cut & Paste to system buffer if clipboard is set
keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
keymap("v", "<leader>p", '"+p', { noremap = true, silent = true })
keymap("n", "<leader>y", '"+yy', { noremap = true, silent = true })
keymap("v", "<leader>y", '"+yy', { noremap = true, silent = true })

-- Telescope Keys (requires "ripgrep" installed via your system package manager)
set("n", "<leader>fb", builtin.buffers, { desc = "Show currently opened buffers" })
set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor" })
set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
set("n", "<leader>fg", builtin.live_grep, { desc = "Find string in cwd" })
set("n", "<leader>fh", builtin.help_tags, { desc = "Open help pages" })
set("n", "<leader>fr", builtin.oldfiles, { desc = "Git branches" })
set("n", "<leader>ht", builtin.help_tags, { desc = "Help Tags" })
set("n", "<leader>gb", builtin.git_branches, { desc = "List recently opened files" })
set("n", "<leader>km", builtin.keymaps, { desc = "Open keymaps" })

-- Quickfix

keymap("n", "<M-n>", ":cnext<CR>", { desc = "Quickfix next", noremap = true })
keymap("n", "<M-p>", ":cprev<CR>", { desc = "Quickfix previous", noremap = true })

-- Obsidian
keymap("n", "<Leader>oS", ":ObsidianQuickSwitch<CR>", { noremap = true })
keymap("n", "<Leader>of", ":ObsidianFollowLink vsplit<CR>", { noremap = true })
keymap("n", "<Leader>ol", ":ObsidianLinks<CR>", { noremap = true })
keymap("n", "<Leader>on", ":ObsidianNew", { noremap = true })
keymap("n", "<Leader>op", ":ObsidianOpen<CR>", { noremap = true })
keymap("n", "<Leader>os", ":ObsidianSearch<CR>", { noremap = true })
keymap("n", "<Leader>ot", ":ObsidianTags", { noremap = true })

-- :only
keymap("n", "<Leader>0", ":only<CR>",
  { desc = "Close all buffers except current focus", noremap = true, silent = true })

-- Git
keymap('n', '<leader>Gp', ':lua push_current_branch()<cr>', { noremap = true })
keymap("n", "<Leader>gf", ":FugitiveInside<CR>", { noremap = true })
keymap(
  "n",
  "<Leader>gls",
  ':G log --pretty=format:"%h - %an, %ar : %s"<CR> ', { desc = "Short formatted git log", noremap = true })

-- Clean up code
keymap("n", "<Leader>ec", "Extract_selected_code_blocks()<CR>", { noremap = true })

-- Toggle Line Numbers
keymap("n", "<Leader>nn", ":lua ToggleLineNumbers()<CR>", { noremap = true })


-- Clear current search
keymap("n", "<Leader>z", ":nohlsearch<CR>", { desc = "Clear current search", noremap = true })

-- Refresh the nvim configuration after modification
keymap("n", "<Leader>sf", "<cmd>source %<CR>",
  { desc = "Reloads the configuration after a change", noremap = true }
)

-- Toggle nvim-tree, load the DirectoryFiles
keymap("n", "<Leader>df", ":NvimTreeToggle()<CR>", { desc = "Toggle Nvimtree", noremap = true })

-- Format buffer
keymap("n", "<Leader>bf", ":lua vim.lsp.buf.format()<CR>", { noremap = true })
keymap("n", "<Leader>bl", ":lua vim.lsp.buf.linting()<CR>", { noremap = true })

-- <F> Keys
-- resize current focused vertical panel by 5 chars
keymap("n", "<F3>", ":vertical resize -5<CR>",
  { desc = "Descrease current window size by 5 chars", noremap = true }
)
keymap("n", "<F4>", ":vertical resize +5<CR>",
  { desc = "Increase current window size by 5 chars", noremap = true }
)

-- Spelling
-- F5 will find next word in doc,
keymap("n", "<F5>", "]s", { desc = "Spell check txt/md files", noremap = true })

-- F6 will prompt to select from a dictionary
keymap("n", "<F6>", "z=", { desc = "Open Dictionary options for word under cursor", noremap = true })

-- F7 will add word to local dictionary
keymap("n", "<F7>", "zg", { desc = "Save a word to a local dictionary", noremap = true })

-- Toggle Vimwiki URL's
keymap("n", "<F8>", ":lua ToggleVimwikiConceallevel()<CR>",
  { desc = "Show url paths in markdown files", noremap = true }
)

-- Mapping for windo diffs
keymap("n", "<leader>wd", ":windo diffthis<CR>",
  { desc = "Diff compare open split buffers", noremap = true })
keymap("n", "<leader>wD", ":windo diffoff<CR>", { desc = "Diff compare off", noremap = true })

-- Mapping for cookstyle
keymap("n", "<leader>cs", ":!/opt/chefkdk/embedded/bin/cookstyle -a %<CR>", { noremap = true })

-- Map a key combination to open Vimwiki and set LCD
keymap("n", "<Leader>ww", ":lua OpenVimwiki()<CR>",
  { desc = "Open Wiki", noremap = true, silent = true }
)

-- Set LCD
keymap(
  "n",
  "<Leader>lcd",
  [[:lua ChangeWorkingDirectoryToGitRoot()<CR>]],
  { desc = "Set nvimtree to local working directory", noremap = true, silent = true }
)

-- Add a mapping to open plugin help
keymap("n", "<Leader>ph", [[:lua OpenPluginHelp()<CR>]], { silent = true })

-- Tabs
keymap("n", "<leader>tp", ":tabprevious<CR>",
  { desc = "Select Previous Tab", noremap = true, silent = true })
keymap("n", "<leader>tn", ":tabNext<CR>", { desc = "Select Next Tab", noremap = true, silent = true })
keymap("n", "<leader>tN", ":tabnew<CR>", { desc = "Open New Tab", noremap = true, silent = true })
keymap("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Current Tab", noremap = true, silent = true })
