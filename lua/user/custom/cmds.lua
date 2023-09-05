-- Set syntax highlighting for Jenkins files with no extension
vim.api.nvim_exec(
  [[
  autocmd BufNewFile,BufRead JenkinsFile,*/Jenkinsfile,Jenkinfile* set filetype=groovy
]],
  false
)

-- Auto run rubocop vore ruby files
vim.api.nvim_exec(
  [[
  autocmd BufWritePost *.rb :silent !rubocop --auto-correct %
]],
  false
)

-- Change the LCD path for Vimwiki
vim.cmd([[autocmd BufEnter *.wiki lcd ~/vimwiki]])

-- Open Terminal
vim.cmd("autocmd! TermOpen term://* lua Set_terminal_keymaps()")

-- Disable perl requirements
vim.g.loaded_perl_provider = 0

-- Setup for vimwiki, if I dont put this here it does not load the markdown, must find a way to fix this
vim.g.vimwiki_list = {
  {
    path = "~/vimwiki/", -- Change this to the path where you want to keep your wiki files
    syntax = "markdown",
    ext = ".md",
    link_format = "fg=blue",
  },
}
