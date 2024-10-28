-- [[ local_fun.lua ]]

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
  local buffer_directory = vim.fn.expand("%:p:h")
  local git_root_path = nil

  -- Run git rev-parse to find the root of the repository
  git_root_path = vim.fn.systemlist("git -C " .. buffer_directory .. " rev-parse --show-toplevel")[1]

  if git_root_path then
    require("nvim-tree").change_dir(git_root_path)
  else
    print("Not in a Git repository")
  end
end

-- Open Vimwiki and set LCD
function OpenVimwiki()
  vim.cmd("VimwikiIndex") -- Open Vimwiki
  vim.cmd("lcd ~/vimwiki") -- Set the LCD to ~/vimwiki
end

-- Terminal Key Mapings
function Set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- Open plugin help if the cursor is on the line that the plugin is referenced
function OpenPluginHelp()
  local line = vim.fn.getline(".")
  local quoted_content = line:match('"([^"]+)"')

  if quoted_content then
    local plugin_name_with_extension = quoted_content:gsub("%.lua$", ""):gsub("%.nvim$", "")
    local plugin_name = plugin_name_with_extension:match("([^/]+)$")
    vim.cmd("help " .. plugin_name)
  else
    print("No double-quoted substring found in the line under the cursor: " .. line)
  end
end

-- vim.api.nvim_command("normal ggVG\"")
-- vim.api.nvim_command("q")

-- Define the macro as 'Trip'
function Trip()
  vim.cmd("read ~/.config/nvim/lua/templates/trip.md")
end

vim.keymap.set("n", "<leader>tt", ":lua Trip()<cr>")
