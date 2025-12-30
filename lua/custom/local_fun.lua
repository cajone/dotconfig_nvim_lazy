-- local_fun.lua

-- Toggle absolute and relative line numbers in the current window
function ToggleLineNumbers()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
end

-- Set terminal mode keymaps for better navigation and escape
function Set_terminal_keymaps()
  local opts = { noremap = true, silent = true }
  local term_opts = { noremap = true }

  -- Exit terminal mode
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], term_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], term_opts)

  -- Window navigation from terminal mode
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], term_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], term_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], term_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], term_opts)

  -- Enter command mode easily
  vim.api.nvim_buf_set_keymap(0, "t", ":", [[<C-\><C-n>:]], opts)
end

function OpenPluginHelp()
  local line = vim.fn.getline(".")
  -- Extract string between quotes
  local plugin_path = line:match("[\"']([^\"']+)[\"']")

  if plugin_path then
    -- Get the part after the slash (e.g., "tpope/vim-fugitive" -> "vim-fugitive")
    local name = plugin_path:match(".*/(.*)") or plugin_path
    -- Clean the name: remove "vim-", ".nvim", and ".vim"
    local clean_name = name:gsub("^vim%-", ""):gsub("%.nvim$", ""):gsub("%.vim$", "")

    -- Try to trigger help
    local ok, _ = pcall(vim.cmd, "help " .. clean_name)
    if not ok then
      -- Fallback: If "fugitive" fails, try the full name "vim-fugitive"
      local ok2, _ = pcall(vim.cmd, "help " .. name)
      if not ok2 then
        print("Could not find help for: " .. clean_name)
      end
    end
  end
end

-- Check for duplicate normal-mode key mappings and print results
function CheckDuplicateMappings()
  local mappings = vim.api.nvim_get_keymap("n")
  local count = {}
  local duplicates = {}

  for _, map in ipairs(mappings) do
    local lhs = map.lhs:gsub(" ", "<Space>")
    if count[lhs] then
      table.insert(duplicates, lhs .. " (Last defined in: " .. (map.desc or "Unknown") .. ")")
    else
      count[lhs] = true
    end
  end

  if #duplicates > 0 then
    print("⚠️ Duplicate Mappings Found:")
    for _, msg in ipairs(duplicates) do
      print(msg)
    end
  else
    print("✅ No duplicate normal-mode mappings found.")
  end
end

-- Keymap to check for duplicate keymaps
vim.keymap.set("n", "<leader>ck", ":lua CheckDuplicateMappings()<CR>", { desc = "Check for duplicate keymaps" })
