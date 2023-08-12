-- [[ keys.lua ]]

-- For info the <Leader> key is mapped to '\'

local map = vim.api.nvim_set_keymap

-- Jumping between windows replacement for Ctrl-w[hjkl]
map("n", "<C-h>", "<C-w>h", { noremap = true })
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })

-- Git
map("n", "<Leader>Gb", ":Git blame<CR>", { noremap = true, silent = true })

vim.cmd([[
command! -nargs=0 FugitiveInside execute "lcd %:h" | :G
]])

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
map("n", "<Leader>NL", ":lua vim.lsp.buf.lint()<CR>", { noremap = true })

-- <F> Keys
-- Toggle Vimwiki URL's
map("n", "<F8>", ":lua ToggleVimwikiConceallevel()<CR>", { noremap = true })

-- resize current focused vertical panel by 5 chars
map("n", "<F12>", ":vertical resize +5<CR>", { noremap = true })


-- Set LCD
map('n', '<Leader>lcd', [[<Cmd>lua ChangeWorkingDirectoryToGitRoot()<CR>]], { noremap = true, silent = true })
