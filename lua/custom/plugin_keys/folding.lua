-- Begining
-- Custom fold configuration for Markdown files

if vim.fn.expand('%:e'):match('markdown') then
  -- Set up fold method and expression for Markdown files
  vim.opt.foldmethod = "expr"
  vim.opt.foldlevelstart = 99  -- Start with all folds closed
  vim.opt.foldminlines = 1     -- Minimum lines to fold

  -- Define the fold expression for markdown headings
  vim.opt_local.foldexpr = [[getline(v:lnum) =~ '^\s*#\+' ? strlen(submatch(0)) : -1]]

  -- Function to toggle folds under the cursor safely
  local function toggle_fold()
    local line = vim.fn.line(".")
    local foldlevel = vim.fn.foldlevel(line)
    if foldlevel == 0 then
      vim.notify("No fold found", vim.log.levels.INFO)
    else
      vim.cmd("normal! za")  -- Toggle the fold at the current line
    end
  end

  -- Helper function to identify and fold headings of a specific level
  local function fold_headings_of_level(level)
    local total_lines = vim.fn.line("$")
    for line = 1, total_lines do
      local line_content = vim.fn.getline(line)
      local heading_pattern = "^" .. string.rep("#", level) .. "%s"
      if vim.fn.match(line_content, heading_pattern) == 0 then
        -- Ensure the cursor is on the line and toggle the fold safely
        vim.fn.setpos(".", {0, line, 1, 0})
        pcall(vim.cmd, "normal! za")
      end
    end
  end

  -- Function to fold markdown headings of specified levels
  local function fold_markdown_headings(levels)
    local saved_view = vim.fn.winsaveview()
    for _, level in ipairs(levels) do
      fold_headings_of_level(level)
    end
    vim.cmd("nohlsearch")
    vim.fn.winrestview(saved_view)
  end

  -- Keymap to toggle fold under cursor
  vim.keymap.set("n", "<CR>", toggle_fold, { desc = "Toggle Fold" })

  -- Keymaps for folding markdown headings based on level
  local fold_keymaps = {
    zj = { 6, 5, 4, 3, 2, 1 },   -- Fold all levels
    zk = { 6, 5, 4, 3, 2 },      -- Fold levels 2 and above
    zl = { 6, 5, 4, 3 },         -- Fold levels 3 and above
    ["z;"] = { 6, 5, 4 }         -- Fold levels 4 and above
  }

  for key, levels in pairs(fold_keymaps) do
    vim.keymap.set("n", key, function()
      vim.cmd("edit!")           -- Reload the buffer to ensure latest state
      vim.cmd("normal! zR")       -- Unfold all first
      fold_markdown_headings(levels)
    end, { desc = string.format("Fold Headings Level %d or Above", #levels) })
  end

  -- Additional keymap to unfold all folds (zR) and fold all at once (zM)
  vim.keymap.set("n", "ze", vim.cmd[[normal! zR]], { desc = "Unfold All" })
  vim.keymap.set("n", "zo", vim.cmd[[normal! zM]], { desc = "Fold All" })
end


