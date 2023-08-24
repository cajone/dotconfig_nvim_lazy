-- Set syntax highlighting for Jenkins files with no extension
vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead JenkinsFile,*/Jenkinsfile set filetype=groovy
]], false)

-- Auto run rubocop vore ruby files
vim.api.nvim_exec([[
  autocmd BufWritePost *.rb :silent !rubocop --auto-correct %
]], false)

