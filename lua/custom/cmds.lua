-- Set syntax highlighting for Jenkins files with no extension
vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead JenkinsFile,*/Jenkinsfile,Jenkinfile* set filetype=groovy
]], false)

-- Auto run rubocop vore ruby files
vim.api.nvim_exec([[
  autocmd BufWritePost *.rb :silent !rubocop --auto-correct %
]], false)

-- Change the LCD path for Vimwiki
vim.cmd([[autocmd BufEnter *.wiki lcd ~/vimwiki]])

-- Open Terminal
vim.cmd('autocmd! TermOpen term://* lua Set_terminal_keymaps()')

-- Set autocmds to trigger the function when opening a new file or changing focus

vim.api.nvim_exec([[
augroup AutoChangeDir
  autocmd!
  autocmd BufEnter * lua ChangeWorkingDirectoryToGitRoot()
  autocmd FocusGained * lua ChangeWorkingDirectoryToGitRoot()
augroup END
]], false)

-- vim.api.nvim_exec([[
-- augroup AutoChangeDir
--   autocmd!
--   autocmd BufEnter * lua ChangeWorkingDirectoryToGitRoot()
--   autocmd FocusGained * lua ChangeWorkingDirectoryToGitRoot()
-- augroup END
-- ]], false)
