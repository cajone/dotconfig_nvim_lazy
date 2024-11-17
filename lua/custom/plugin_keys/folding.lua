-------------------------------------------------------------------------------
--                           Folding Section
-------------------------------------------------------------------------------

-- Use <CR> to toggle fold when in normal mode
vim.keymap.set("n", "<CR>", function()
  local line = vim.fn.line(".")
  local foldlevel = vim.fn.foldlevel(line)
  if foldlevel == 0 then
    vim.notify("No fold found", vim.log.levels.INFO)
  else
    vim.cmd("normal! za")
  end
end, { desc = "Toggle Fold" })

-- Helper function to set fold method and expression
local function set_foldmethod_expr()
  if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.foldmethod = "expr"
    local function require_ui(module)
      return string.format("v:lua.%s()", module .. '.ui.foldexpr()')
    end
    vim.opt.foldexpr = require_ui('lazyvim.util')
    vim.opt.foldtext = ""
  else
    vim.opt.foldmethod = "indent"
    vim.opt.foldtext = function()
      return require('lazyvim.util').ui.foldtext()
    end
  end
  vim.opt.foldlevelstart = 99 -- Set initial fold level
end

-- Helper function to fold headings of a specific level
local function fold_headings_of_level(level)
  local total_lines = vim.fn.line("$")
  for line = 1, total_lines do
    local line_content = vim.fn.getline(line)
    if line_content:match("^" .. string.rep("#", level) .. "%s") then
      vim.fn.cursor(line, 1)
      if vim.fn.foldclosed(line) == -1 then
        vim.cmd("normal! za")
      end
    end
  end
end

-- Function to fold markdown headings of specified levels
local function fold_markdown_headings(levels)
  set_foldmethod_expr()
  local saved_view = vim.fn.winsaveview()
  for _, level in ipairs(levels) do
    fold_headings_of_level(level)
  end
  vim.cmd("nohlsearch")
  vim.fn.winrestview(saved_view)
end

-- Keymap to unfold all headings (level 2 or above)
vim.keymap.set("n", "zu", function()
  vim.cmd("edit!")
  vim.cmd("normal! zR") -- Unfold all
end, { desc = "Unfold All Headings" })

-- Keymap to fold the heading under the cursor
vim.keymap.set("n", "zi", function()
  vim.cmd("normal gk")
  vim.cmd("normal! za")
end, { desc = "Fold Current Heading" })

-- Keymaps for folding markdown headings based on level
local fold_keymaps = {
  zj = { 6, 5, 4, 3, 2, 1 },
  zk = { 6, 5, 4, 3, 2 },
  zl = { 6, 5, 4, 3 },
  ["z;"] = { 6, 5, 4 }
}

for key, levels in pairs(fold_keymaps) do
  vim.keymap.set("n", key, function()
    vim.cmd("edit!")
    vim.cmd("normal! zR") -- Unfold all first
    fold_markdown_headings(levels)
  end, { desc = string.format("Fold Headings Level %d or Above", table.getn(levels)) })
end

-------------------------------------------------------------------------------
--                         End Folding Section
-------------------------------------------------------------------------------

