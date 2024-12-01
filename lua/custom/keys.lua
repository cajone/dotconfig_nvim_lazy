-- keys.lua: Person keymaps, leader key is '\' by default

-- Jumping between windows replacement for Ctrl-w[hjkl]
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- Cut & Paste to system buffer if clipboard is set
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>y", '"+yy', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>y", '"+yy', { noremap = true, silent = true })

-- Telescope Keys (requires "ripgrep" installed via your system package manager)
local builtin = require("telescope.builtin")
local set = vim.keymap.set

set("n", "<leader>fb", builtin.buffers, { desc = "Show currently opened buffers" })
set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor" })
set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
set("n", "<leader>fg", builtin.live_grep, { desc = "Find string in cwd" })
set("n", "<leader>fh", builtin.help_tags, { desc = "Open help pages" })
set("n", "<leader>fr", builtin.oldfiles, { desc = "List recently opened files" })
set("n", "<leader>km", builtin.keymaps, { desc = "Open keymaps" })

-- GP AI
vim.api.nvim_set_keymap("n", "<Leader>ja", ":GpAgent", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jaq", ":GpAgent qwen32<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jal", ":GpAgent Llama3.2<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jr", ":GpRewrite<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jd", ":GpChatDelete<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jf", ":GpChatFinder<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jA", ":GpAppend<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jn", ":GpTabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jp", ":GpPrepend<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>jt", ":GpChatToggle<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<Leader>jz", ":GpPopup<CR>", { noremap = true })

-- Obsidian

vim.api.nvim_set_keymap("n", "<Leader>oS", ":ObsidianQuickSwitch<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>of", ":ObsidianFollowLink vsplit<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>ol", ":ObsidianLinks<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>on", ":ObsidianNew", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>op", ":ObsidianOpen<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>os", ":ObsidianSearch<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>ot", ":ObsidianTags", { noremap = true })

-- Remote SSH connections
vim.api.nvim_set_keymap("n", "<Leader>rs", ":RemoteStart<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>rS", ":RemoteStop<CR>", { noremap = true })

-- :only
vim.api.nvim_set_keymap(
  "n",
  "<Leader>0",
  ":only<CR>",
  { desc = "Close all buffers except current focus", noremap = true, silent = true }
)

-- Git
vim.api.nvim_set_keymap("n", "<Leader>gf", ":FugitiveInside<CR>", { noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<Leader>gls",
  ':G log --pretty=format:"%h - %an, %ar : %s"<CR> ',
  { desc = "Short formatted git log", noremap = true }
)

-- Clean up code
vim.api.nvim_set_keymap("n", "<Leader>ec", "Extract_selected_code_blocks()<CR>", { noremap = true })

-- Toggle Line Numbers
vim.api.nvim_set_keymap("n", "<Leader>nn", ":lua ToggleLineNumbers()<CR>", { noremap = true })

-- Dismiss notices
vim.api.nvim_set_keymap("n", "<leader>Nn", "<cmd>NoiceDismiss<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Ne", "<cmd>NoiceEnable<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Nd", "<cmd>NoiceDisable<CR>", { noremap = true, silent = true })

--- FzfLua
vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>FzfLua helptags<CR>", { noremap = true, silent = true })

-- Clear current search
vim.api.nvim_set_keymap("n", "<Leader>z", ":nohlsearch<CR>", { desc = "Clear current search", noremap = true })

-- Refresh the nvim configuration after modification
vim.api.nvim_set_keymap(
  "n",
  "<Leader>sf",
  "<cmd>source %<CR>",
  { desc = "Reloads the configuration after a change", noremap = true }
)

-- Toggle nvim-tree, load the DirectoryFiles
vim.api.nvim_set_keymap("n", "<Leader>df", ":NvimTreeToggle()<CR>", { desc = "Toggle Nvimtree", noremap = true })

-- Format buffer
vim.api.nvim_set_keymap("n", "<Leader>NF", ":lua vim.lsp.buf.format()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>NL", ":lua vim.lsp.buf.linting()<CR>", { noremap = true })

-- <F> Keys
-- resize current focused vertical panel by 5 chars
vim.api.nvim_set_keymap(
  "n",
  "<F3>",
  ":vertical resize -5<CR>",
  { desc = "Descrease current window size by 5 chars", noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<F4>",
  ":vertical resize +5<CR>",
  { desc = "Increase current window size by 5 chars", noremap = true }
)

-- Spelling
-- F5 will find next word in doc,
vim.api.nvim_set_keymap("n", "<F5>", "]s", { desc = "Spell check txt/md files", noremap = true })

-- F6 will prompt to select from a dictionary
vim.api.nvim_set_keymap("n", "<F6>", "z=", { desc = "Open Dictionary options for word under cursor", noremap = true })

-- F7 will add word to local dictionary
vim.api.nvim_set_keymap("n", "<F7>", "zg", { desc = "Save a word to a local dictionary", noremap = true })

-- Toggle Vimwiki URL's
vim.api.nvim_set_keymap(
  "n",
  "<F8>",
  ":lua ToggleVimwikiConceallevel()<CR>",
  { desc = "Show url paths in markdown files", noremap = true }
)

-- Mapping for windo diffs
vim.api.nvim_set_keymap(
  "n",
  "<leader>wd",
  ":windo diffthis<CR>",
  { desc = "Diff compare open split buffers", noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>wD", ":windo diffoff<CR>", { desc = "Diff compare off", noremap = true })

-- Mapping for cookstyle
vim.api.nvim_set_keymap("n", "<leader>cs", ":!/opt/chefkdk/embedded/bin/cookstyle -a %<CR>", { noremap = true })

-- Map a key combination to open Vimwiki and set LCD
vim.api.nvim_set_keymap(
  "n",
  "<Leader>ww",
  ":lua OpenVimwiki()<CR>",
  { desc = "Open Wiki", noremap = true, silent = true }
)

-- Set LCD
vim.api.nvim_set_keymap(
  "n",
  "<Leader>lcd",
  [[<Cmd>lua ChangeWorkingDirectoryToGitRoot()<CR>]],
  { desc = "Set nvimtree to local working directory", noremap = true, silent = true }
)

-- Add Frozen string literal to ruby files
-- vim.api.nvim_set_keymap('n', '<Leader>asl', ':lua AddFrozenStringLiteral()<CR>', { noremap = true, silent = true })

-- Add a mapping to open plugin help
vim.api.nvim_set_keymap("n", "<Leader>ph", [[:lua OpenPluginHelp()<CR>]], { silent = true })

-- MarkdownToc
vim.api.nvim_set_keymap(
  "n",
  "<Leader>toc",
  ":GenTocGFM<CR>",
  { desc = "Generate TOC ( in situ )", noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<Leader>tou", ":UpdateToc<CR>", { desc = "Update TOC", noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<Leader>tor",
  ":RemoveToc<CR>",
  { desc = "Remove TOC ( in situ )", noremap = true, silent = true }
)

-- Instant Markdown Preview on and off mappings
-- vim.api.nvim_set_keymap('n', '<leader>md', ':InstantMarkdownPreview<CR>', { desc = "Instant Markdown preview in browser", noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>mo', ':InstantMarkdownStop<CR>', { desc = "Instant Markdown preview off", noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<leader>md",
  ":MarkdownPreview<CR>",
  { desc = "Instant Markdown preview in browser", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>mo",
  ":MarkdownPreviewStop<CR>",
  { desc = "Instant Markdown preview off", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>mt",
  ":MarkdownPreviewToggle<CR>",
  { desc = "Instant Markdown preview toggle", noremap = true, silent = true }
)

-- Tabs
vim.api.nvim_set_keymap(
  "n",
  "<leader>tp",
  ":tabprevious<cr>",
  { desc = "Select Previous Tab", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabNext<cr>", { desc = "Select Next Tab", noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tN", ":tabnew<cr>", { desc = "Open New Tab", noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>tc",
  ":tabclose<cr>",
  { desc = "Close Current Tab", noremap = true, silent = true }
)
