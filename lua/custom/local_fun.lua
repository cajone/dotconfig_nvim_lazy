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


-- Change the LCD to the current git buffer root
function ChangeWorkingDirectoryToGitRoot()
    local bufnr = vim.fn.bufnr('%')
    local buffer_directory = vim.fn.expand('%:p:h')

    -- Run git rev-parse to find the root of the repository
    local git_root = vim.fn.systemlist('git -C ' .. buffer_directory .. ' rev-parse --show-toplevel')[1]

    if git_root then
        vim.fn.execute("lcd " .. git_root)
    else
        print("Not in a Git repository")
    end
end
