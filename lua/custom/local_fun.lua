
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
  --    local bufnr = vim.fn.bufnr('%')
  local buffer_directory = vim.fn.expand('%:p:h')

  -- Run git rev-parse to find the root of the repository
  local git_root = vim.fn.systemlist('git -C ' .. buffer_directory .. ' rev-parse --show-toplevel')[1]

  if git_root then
    vim.fn.execute("lcd " .. git_root)
  else
    print("Not in a Git repository")
  end
end

-- List of packages that can be installed if :InstallMasonConfig() is called
local masonCommands = {
  ":MasonInstall lua-language-server",
--  ":MasonInstall bash-language-server",
  ":MasonInstall groovy-language-server",
  ":MasonInstall tree-sitter-cli",
  ":MasonInstall rubocop",
  ":MasonInstall luacheck",
  ":MasonInstall shellcheck",
--  ":MasonInstall prettier",
  ":MasonInstall luaformatter",
  ":MasonInstall beautysh",
}


-- Run this sparingly as it will re-install everyting i the masonCommands above
function InstallMasonConfig()
  for _, command in ipairs(masonCommands) do
    vim.cmd(command)
  end
end

-- When using Rubocop it will complain about frozen string literals
-- This function is a keybinding to put the string literal in place
-- Keybinding '\asl' (Add String Literal )
function AddFrozenStringLiteral()
  -- Move to the first line
  vim.cmd('normal! gg')

  -- Check if the line is empty or already contains the frozen string literal
  local line = vim.fn.getline('.')
  if vim.fn.empty(line) == 1 or line:match('^%s*#%s*frozen_string_literal:%s*true%s*$') then
    return
  end

  -- Insert the frozen string literal line
  vim.fn.append(0, '# frozen_string_literal: true')

  -- Save the file
  vim.cmd('write')
end

-- Open Vimwiki and set LCD
function OpenVimwiki()
    -- Open Vimwiki
    vim.cmd("VimwikiIndex")

    -- Set the LCD to ~/vimwiki
    vim.cmd("lcd ~/vimwiki")
end

-- Termainal Key Mapings
function Set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- Open plugin help if the cursor is on the line that the plugin is refeerenced
function OpenPluginHelp()
    local line = vim.fn.getline('.')
    local quoted_content = line:match('"([^"]+)"')

    if quoted_content then
        local plugin_name_with_extension = quoted_content:gsub('%.lua$', ''):gsub('%.nvim$', '')
        local plugin_name = plugin_name_with_extension:match('([^/]+)$')
        vim.cmd('help ' .. plugin_name)
    else
        print('No double-quoted substring found in the line under the cursor: ' .. line)
    end
end
