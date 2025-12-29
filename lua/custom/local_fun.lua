-- local_fun.lua

-- Define the function to toggle line numbers and relative numbers
function ToggleLineNumbers()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
end

-- Terminal Key Mappings
function Set_terminal_keymaps()
  local opts = { noremap = true, silent = true }
  local term_opts = { noremap = true }

  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], term_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], term_opts)

  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], term_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], term_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], term_opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], term_opts)

  -- Additional useful terminal mappings
  vim.api.nvim_buf_set_keymap(0, "t", ":", [[<C-\><C-n>:]], opts)
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

function CheckDuplicateMappings()
  local mappings = vim.api.nvim_get_keymap("n") -- Check Normal mode
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

-- Map it so you can run it anytime
vim.keymap.set("n", "<leader>ck", ":lua CheckDuplicateMappings()<CR>", { desc = "Check for duplicate keymaps" })
