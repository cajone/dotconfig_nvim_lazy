-- keys.lua: Person keymaps, leader key is '\' by default
local keymap = vim.api.nvim_set_keymap
local set = vim.keymap.set
local builtin = require("telescope.builtin")

-- Terminal keybinding
keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Map <leader>fe (File Edit) to type ':edit ' and put cursor there
vim.keymap.set("n", "<leader>fe", ":edit ", {
  noremap = true,
  silent = false, -- We want to see ':edit ' appear on the command line
  desc = "Edit (open) file with wildmenu completion",
})

-- Optional: Map <leader>fs (File SaveAs) if you often save files with a new name
vim.keymap.set("n", "<leader>fs", ":saveas ", {
  noremap = true,
  silent = false,
  desc = "Save current file with a new name",
})

-- --- Wildmenu Configuration (ensure it's active) ---
vim.opt.wildmenu = true       -- Enable wildmenu
vim.opt.wildmode = "full"     -- Complete longest common string, then list all matches
vim.opt.wildignorecase = true -- Ignore case when completing
vim.opt.wildignore = {        -- Files/directories to ignore during completion
  "*.o",
  "*.obj",                    -- Object files
  "*.pyc",
  "*.class",                  -- Compiled Python/Java
  "*.swp",
  "*.swo",                    -- Swap files
  "*.DS_Store",               -- macOS specific
  "node_modules",             -- Common JS dependency folder
  "build",                    -- Common build folder
  "vendor",                   -- Common dependency folder
  ".git",
  ".svn",                     -- Version control folders
}

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
set("n", "<leader>fr", builtin.oldfiles, { desc = "List recently opened files" })
set("n", "<leader>km", builtin.keymaps, { desc = "Open keymaps" })

-- Define the function to open help tags in a new tab and make it full-screen
function Open_help_tags()
  vim.cmd.tabnew() -- Open a new tab page
  vim.cmd.only()   -- Make the current tab the only one open
  require("telescope.builtin").help_tags()
end

-- Set the keybinding for the function
keymap("n", "<leader>ht", ":lua Open_help_tags()<CR>", { noremap = true, silent = true, desc = "Help Tags" })

-- :only
keymap(
  "n",
  "<Leader>0",
  ":only<CR>",
  { desc = "Close all buffers except current focus", noremap = true, silent = true }
)

-- Toggle Line Numbers
keymap("n", "<Leader>nn", ":lua ToggleLineNumbers()<CR>", { noremap = true })

-- Clear current search
keymap("n", "<Leader>z", ":nohlsearch<CR>", { desc = "Clear current search", noremap = true })

-- Refresh the nvim configuration after modification
keymap("n", "<Leader>sf", "<cmd>source %<CR>", { desc = "Reloads the configuration after a change", noremap = true })

-- Format buffer
keymap("n", "<Leader>NF", ":lua vim.lsp.buf.format()<CR>", { noremap = true })
keymap("n", "<Leader>NL", ":lua vim.lsp.buf.linting()<CR>", { noremap = true })

-- <F> Keys
-- resize current focused vertical panel by 5 chars
keymap("n", "<F3>", ":vertical resize -5<CR>", { desc = "Descrease current window size by 5 chars", noremap = true })
keymap("n", "<F4>", ":vertical resize +5<CR>", { desc = "Increase current window size by 5 chars", noremap = true })

-- Spelling
keymap("n", "<F5>", "]s", { desc = "Spell check txt/md files", noremap = true, silent = true })
keymap("n", "<F6>", "z=", { desc = "Open Dictionary options for word under cursor", noremap = true }) -- F6 will open spelling suggestions
keymap("n", "<F7>", "zg", { desc = "Save a word to a local dictionary", noremap = true })             -- F7 will add word under cursor to local dictionary

-- Mapping for windo diffs
keymap("n", "<leader>wd", ":windo diffthis<CR>", { desc = "Diff compare open split buffers", noremap = true })
keymap("n", "<leader>wD", ":windo diffoff<CR>", { desc = "Diff compare off", noremap = true })

-- Mapping for cookstyle
keymap("n", "<leader>cs", ":!/opt/chefkdk/embedded/bin/cookstyle -a %<CR>", { noremap = true })

-- Add a mapping to open plugin help
keymap("n", "<leader>ph", [[:lua OpenPluginHelp()<CR>]], { silent = true })

-- Tabs
keymap("n", "<leader>tp", ":tabprevious<CR>", { desc = "Select Previous Tab", noremap = true, silent = true })
keymap("n", "<leader>tn", ":tabNext<CR>", { desc = "Select Next Tab", noremap = true, silent = true })
keymap("n", "<leader>tN", ":tabnew<CR>", { desc = "Open New Tab", noremap = true, silent = true })
keymap("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Current Tab", noremap = true, silent = true })

-- UNUSED KEYMAPS FOR NOW
-- *** NEW: Avante.nvim Keymaps ***
-- set("n", "<leader>al", "<cmd>AvanteListShortcuts<CR>", { desc = "Avante: List all custom shortcuts" })
-- set("n", "<leader>am", "<cmd>AvanteModels<CR>", { desc = "Avante: Select LLM model" })
-- *** END Avante.nvim Keymaps ***

-- Obsidian
-- keymap("n", "<Leader>oS", ":ObsidianQuickSwitch<CR>", { noremap = true })
-- keymap("n", "<Leader>of", ":ObsidianFollowLink vsplit<CR>", { noremap = true })
-- keymap("n", "<Leader>ol", ":ObsidianLinks<CR>", { noremap = true })
-- keymap("n", "<Leader>on", ":ObsidianNew", { noremap = true })
-- keymap("n", "<Leader>op", ":ObsidianOpen<CR>", { noremap = true })
-- keymap("n", "<Leader>os", ":ObsidianSearch<CR>", { noremap = true })
-- keymap("n", "<Leader>ot", ":ObsidianTags", { noremap = true })
