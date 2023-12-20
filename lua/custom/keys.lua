-- [[ keys.lua ]]

-- For info the <Leader> key is mapped to '\'
  local map = vim.api.nvim_set_keymap

-- Jumping between windows replacement for Ctrl-w[hjkl]
  map("n", "<C-h>", "<C-w>h", { noremap = true })
  map("n", "<C-j>", "<C-w>j", { noremap = true })
  map("n", "<C-k>", "<C-w>k", { noremap = true })
  map("n", "<C-l>", "<C-w>l", { noremap = true })


  map("n", "<C-c>", '"yy', { noremap = true })

-- Telescope Keys some of this requires "ripgrep" install using you system package manager
  local builtin = require('telescope.builtin')
  local set = vim.keymap.set
  set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy find files in cwd" })
  set('n', '<leader>fr', builtin.oldfiles, { desc = "List recently opened files" })
  set('n', '<leader>fg', builtin.live_grep, { desc = "Find string in cwd" })
  set('n', '<leader>fc', builtin.grep_string, { desc = "Find string under cursor" })
  set('n', '<leader>fb', builtin.buffers, { desc = "Show currently opend buffers" })
  set('n', '<leader>fh', builtin.help_tags, { desc = "Open help pages" })

-- Mksession functions
  set('n', '<leader>sl', [[:LoadSessions<CR>]], { noremap = true, silent = true })
  set('n', '<leader>ss', [[:SaveSessions<CR>]], { noremap = true, silent = true })
  set('n', '<leader>sc', [[:ClearSessions<CR>]], { noremap = true, silent = true })

-- Git-Worktree  local telescope = require('telescope')
  set('n', '<leader>sr', ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>" )
  set('n', '<leader>sR', ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>" )

-- :only
  map("n", "<Leader>0", ":only<CR>", { noremap = true, silent = true })

-- Git
  map("n", "<Leader>Gb", ":G blame<CR>", { noremap = true, silent = true })


  map('n', '<Leader>gf', ':FugitiveInside<CR>', { noremap = true })

-- Toggle Line Numbers
  map("n", "<Leader>nn", ":lua ToggleLineNumbers()<CR>", { noremap = true })

-- Clear current search
  map("n", "<Leader>z", ":nohlsearch<CR>", { noremap = true })

-- Resource the nvim configuration after modification
  map("n", "<Leader>sf", ":source %<CR>", { noremap = true })

-- Toggle nvim-tree, load the DirectoryFiles
  map("n", "<Leader>df", ":NvimTreeToggle()<CR>", { noremap = true })

-- Format buffer
  map("n", "<Leader>NF", ":lua vim.lsp.buf.format()<CR>", { noremap = true })
  map("n", "<Leader>NL", ":lua vim.lsp.buf.linting()<CR>", { noremap = true })

-- <F> Keys
  -- resize current focused vertical panel by 5 chars
    map("n", "<F3>", ":vertical resize -5<CR>", { noremap = true })
    map("n", "<F4>", ":vertical resize +5<CR>", { noremap = true })
  -- Spelling 
    -- F5 will find next word in doc, 
    map("n", "<F5>", "]s", { noremap = true })
    -- F7 will prompt to select from a dictionary
    map("n", "<F6>", "z=", { noremap = true })
    -- F6 will add word to local dictionary
    map("n", "<F7>", "zg", { noremap = true })
  -- Toggle Vimwiki URL's
    map("n", "<F8>", ":lua ToggleVimwikiConceallevel()<CR>", { noremap = true })

-- Mapping for windo diffs
    map('n', "<leader>wd", ":windo diffthis<CR>", { noremap = true })
    map('n', "<leader>wD", ":windo diffoff<CR>", { noremap = true })

-- Mapping for cookstyle
    map("n", "<leader>cs", ":!cookstyle -a %<CR>", { noremap = true })

-- Map a key combination to open Vimwiki and set LCD
  vim.api.nvim_set_keymap('n', '<Leader>ww', ':lua OpenVimwiki()<CR>', { noremap = true, silent = true })

-- Set LCD
  map('n', '<Leader>lcd', [[<Cmd>lua ChangeWorkingDirectoryToGitRoot()<CR>]], { noremap = true, silent = true })


-- Add Frozen string literal to ruby files
  map('n', '<Leader>asl', ':lua AddFrozenStringLiteral()<CR>', { noremap = true, silent = true })


-- Add a mapping to open plugin help
  vim.api.nvim_set_keymap('n', '<Leader>ph', [[:lua OpenPluginHelp()<CR>]], { silent = true })

-- MarkdownToc
  map("n", "<Leader>tc",  ":GenTocGFM<CR>", { noremap = true, silent = true })
  map('n', '<Leader>tcu', ':UpdateToc<CR>', { noremap = true, silent = true })
  map('n', '<Leader>tcr', ':RemoveToc<CR>', { noremap = true, silent = true })

-- Instant Markdown Preview on and off mappings
  map('n', '<leader>md', ':InstantMarkdownPreview<CR>', { noremap = true, silent = true })
  map('n', '<leader>mo', ':InstantMarkdownStop<CR>', { noremap = true, silent = true })


-- Tabs
  map('n', '<leader>tp',  ':tabprevious<cr>', { noremap = true, silent = true })
  map('n', '<leader>tn',  ':tabNext<cr>', { noremap = true, silent = true })
  map('n', '<leader>tN',  ':tabnew<cr>', { noremap = true, silent = true })
  map('n', '<leader>tc',  ':tabclose<cr>', { noremap = true, silent = true })



