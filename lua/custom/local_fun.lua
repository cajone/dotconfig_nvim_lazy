-- [[ local_fun.lua ]]

-- Save a session before leaving
function SaveSessionOnExit()
 -- Get the current date and timestamp
  local timestamp = vim.fn.strftime("%Y%m%d%H%M")

  -- Define the session file path
  local session_path = vim.fn.stdpath('config') .. '/nvim/.mksession/' .. timestamp .. '.vim'

  -- Save the session
  vim.cmd('mksession! ' .. session_path)
end

-- Define a function to list and load mksession files
local function list_and_load_sessions()
  local session_dir = vim.fn.stdpath('config') .. '/nvim/.mksession/'

  -- Use Telescope to list the session files
  require('telescope.builtin').find_files({
    prompt_title = 'Load Session',
    cwd = session_dir,
    file_ignore_patterns = {'__Session__.vim'},
    attach_mappings = function(_, map)
      -- When a session is selected, load it with :source
      map('i', '<CR>', function(prompt_bufnr)
        local session_path = require('telescope.actions').get_selected_entry(prompt_bufnr).path
        vim.cmd('source ' .. session_path)
        require('telescope.actions').close(prompt_bufnr)
      end)

      return true
    end,
  })
end

-- Create a custom Telescope command to list and load sessions
vim.cmd([[command! LoadSessions lua list_and_load_sessions()]])


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
  local buffer_directory = vim.fn.expand('%:p:h')
  local git_root_path = nil

  -- Check if the buffer's file type is 'fugitive'
  --   if vim.bo.filetype == 'fugitive' then
  --       local is_git_repo = vim.fn.system('git -C ' .. buffer_directory .. ' rev-parse --is-inside-work-tree') == 'true\n'
  --       if is_git_repo then
  --           git_root_path = vim.fn.system('git -C ' .. buffer_directory .. ' rev-parse --show-toplevel')
  --           require'nvim-tree'.change_dir(git_root_path)
  --           return
  --       end
  --   end

  -- Run git rev-parse to find the root of the repository
  git_root_path = vim.fn.systemlist('git -C ' .. buffer_directory .. ' rev-parse --show-toplevel')[1]

  if git_root_path then
    require 'nvim-tree'.change_dir(git_root_path)
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

-- Open plugin help if the cursor is on the line that the plugin is referenced
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
