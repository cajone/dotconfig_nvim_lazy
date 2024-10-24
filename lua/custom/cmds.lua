-- Set syntax highlighting for Jenkins files with no extension
vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead JenkinsFile,*/Jenkinsfile,Jenkinfile* set filetype=groovy
  autocmd BufNewFile,BufRead *.json set filetype=json
]], false)

vim.cmd([[colorscheme tokyonight]])  -- ok now load the colorscheme

-- Auto run rubocop over ruby files
-- vim.api.nvim_exec([[
--   autocmd BufWritePost *.rb :silent !rubocop --auto-correct %
-- ]], false)

-- Change the LCD path for Vimwiki
vim.cmd([[autocmd BufEnter *.wiki lcd ~/vimwiki]])

-- Open Terminal
vim.cmd('autocmd! TermOpen term://* lua Set_terminal_keymaps()')

-- Auto Save session before exit
-- vim.cmd([[autocmd VimLeave * lua SaveSessionOnExit()]])

-- Create a custom Telescope command to list and load sessions
vim.cmd([[command! LoadSessions lua LoadSession()]])
vim.cmd([[command! SaveSessions lua SaveSession()]])
vim.cmd([[command! ClearSessions lua ClearSession()]])

-- Turn spelling on if editing either txt or md files
-- Enable spell checking for specific filetypes
vim.cmd[[
  autocmd BufRead,BufNewFile *.txt,*.md setlocal spell
]]


-- Fugitive
vim.cmd([[command! -nargs=0 FugitiveInside execute "lcd %:h" | :G]])


