-- [[ local_fun.lua ]]

-- Save a Mksession 
function SaveSession()
 -- Get the current date and timestamp
  local timestamp = vim.fn.strftime("%Y%m%d%H%M")
  vim.cmd(':NvimTreeClose')

  -- Get the current working directory
  local cwd = vim.fn.getcwd()

  -- Extract the base name of the directory
  local cwd_basename = vim.fn.fnamemodify(cwd, ':t')

  -- Convert the base name to a valid filename
  local cwd_filename = vim.fn.substitute(cwd_basename, '/', '_', 'g')

  -- Define the session file path
  local session_dir = vim.fn.stdpath('config') .. '/.mksession/'
  local session_path = session_dir .. cwd_filename .. '_' .. timestamp .. '.vim'

  -- Create the session directory if it doesn't exist
  if vim.fn.isdirectory(session_dir) == 0 then
    os.execute('mkdir -p ' .. session_dir)
  end

  -- Save the session
  vim.cmd('mksession!' .. session_path)
end

-- Load a mkSession from a list of saved ones
function LoadSession()
  local session_dir = vim.fn.stdpath('config') .. '/.mksession/'

  local session_files = vim.fn.glob(session_dir .. '*.vim', false, true)

  if #session_files == 0 then
    print('No session files found.')
    return
  end

  print('Select a session to load:')
  for i, session_file in ipairs(session_files) do
    print(i .. '. ' .. session_file)
  end

  local selection = vim.fn.input('Enter the number of the session to load: ')

  if tonumber(selection) and tonumber(selection) >= 1 and tonumber(selection) <= #session_files then
    local session_path = session_files[tonumber(selection)]
    vim.cmd('source ' .. session_path)
    ChangeWorkingDirectoryToGitRoot()
    -- Ensure nvim-tree is loaded and displayed
    if vim.fn.exists(':NvimTreeToggle') == 0 then
      vim.cmd('NvimTreeToggle')
    end
  else
    print('Invalid selection.')
  end
end

-- Define a function to clean the mksession directory
function ClearSession()
  local session_dir = vim.fn.stdpath('config') .. '/.mksession/'

  -- Get a list of session files sorted by modification time
  local session_files = vim.fn.systemlist('ls -t ' .. session_dir)

  -- Keep the last 5 session files
  local num_to_keep = 5
  for i = 1, #session_files do
    if i > num_to_keep then
      local session_path = session_dir .. session_files[i]
      vim.fn.delete(session_path)
      print('Deleted: ' .. session_path)
    end
  end

  print('Session directory cleaned.')
end


-- Define the function to toggle line numbers and relative numbers
function ToggleLineNumbers()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
  -- Add a call here to turn off :Gitsigns toggle_signs 
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
--  function InstallMasonConfig()
--    for _, command in ipairs(masonCommands) do
--      vim.cmd(command)
--    end
--  end

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


-- function Extract_selected_code_blocks()
--     local start_line, _, _, start_col = unpack(vim.fn.getpos("'<"))
--     local _, end_line, _, end_col = unpack(vim.fn.getpos("'>"))
-- 
--     local lines = vim.fn.getline(start_line, end_line)
-- 
--     local code_blocks = {}
--     local current_block = {}
--     local in_code_block = false
-- 
--     for i, line in ipairs(lines) do
--         local _, _, language = line:find("^%s*```([%a%d]*)%s*$")
-- 
--         if language then
--             in_code_block = not in_code_block
--         elseif in_code_block then
--             table.insert(current_block, line)
--         end
-- 
--         if not in_code_block or i == #lines then
--             if #current_block > 0 then
--                 table.insert(code_blocks, table.concat(current_block, "\n"))
--                 current_block = {}
--             end
--         end
--     end
-- 
--     -- Append the extracted code blocks to the end of the buffer
--     vim.fn.append(end_line, code_blocks)
-- 
--     -- Print the extracted code blocks
--     for _, block in ipairs(code_blocks) do
--         print("Code Block:")
--         print(block)
--         print("------------")
--     end
-- end

