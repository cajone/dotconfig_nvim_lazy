-- [[ local_fun.lua ]]

-- Define the function to toggle line numbers and relative numbers
function ToggleLineNumbers()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
end

-- Toggle the ability to see url links in VimWiki
function ToggleVimwikiConceallevel()
  if vim.opt.conceallevel == 0 then
    vim.opt.conceallevel = 2
    return
  else
    vim.opt.conceallevel = 0
    return
  end
end
