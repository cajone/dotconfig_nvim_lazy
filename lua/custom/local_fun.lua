-- [[ local_fun.lua ]]

-- Save a Mksession 
function SaveSession()
  local timestamp = vim.fn.strftime("%Y%m%d%H%M")                       -- Get the current date and timestamp
  vim.cmd(':NvimTreeClose')

  local cwd = vim.fn.getcwd()                                           -- Get the current working directory
  local cwd_basename = vim.fn.fnamemodify(cwd, ':t')                    -- Extract the base name of the directory
  local cwd_filename = vim.fn.substitute(cwd_basename, '/', '_', 'g')   -- Convert the base name to a valid filename

  local session_dir = vim.fn.stdpath('config') .. '/.mksession/'                  -- Define the session dir 
  local session_path = session_dir .. cwd_filename .. '_' .. timestamp .. '.vim'  -- Define the session path

  -- Create the session directory if it doesn't exist
  if vim.fn.isdirectory(session_dir) == 0 then
    os.execute('mkdir -p ' .. session_dir)
  end

  vim.cmd('mksession!' .. session_path)                                 -- Save the session
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

-- Open Vimwiki and set LCD
function OpenVimwiki()
  vim.cmd("VimwikiIndex")    -- Open Vimwiki
  vim.cmd("lcd ~/vimwiki")   -- Set the LCD to ~/vimwiki
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

