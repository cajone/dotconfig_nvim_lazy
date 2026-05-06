-- Consolidated Neowiki Configuration
-- Replaces old Vimwiki residue and local_func.lua logic

local M = {
  "echaya/neowiki.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
  },
}

-- --- INTERNAL UTILITIES ---
-- (Logic previously in local_func.lua)

local function toggle_conceal()
  local level = vim.opt_local.conceallevel:get()
  if level == 0 then
    vim.opt_local.conceallevel = 2
    print("Conceal: ON")
  else
    vim.opt_local.conceallevel = 0
    print("Conceal: OFF")
  end
end

local function insert_trip_template()
  -- Modern way to append a template file
  local template_path = vim.fn.expand("~/.config/nvim/lua/templates/trip.md")
  if vim.fn.filereadable(template_path) == 1 then
    vim.cmd("read " .. template_path)
  else
    print("Template not found: " .. template_path)
  end
end

-- --- PLUGIN CONFIGURATION ---

M.init = function()
  -- Autocmd to set defaults for wiki/markdown files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "neowiki" },
    callback = function()
      vim.opt_local.conceallevel = 2
      -- Buffer-local keybinds for Wiki files
      local opts = { buffer = true, silent = true }
      vim.keymap.set("n", "<leader>tc", toggle_conceal, { buffer = true, desc = "Toggle Wiki Conceal" })
      vim.keymap.set("n", "<F8>", toggle_conceal, { buffer = true, desc = "Toggle Wiki Conceal (Legacy F8)" })
      vim.keymap.set("n", "<leader>tt", insert_trip_template, { buffer = true, desc = "Insert Trip Template" })
    end,
  })
end

M.config = function(_, opts)
  require("neowiki").setup(opts)
  require("render-markdown").setup({
    link = {
      enabled = true,
      render_mode = "compact",
    },
  })
end

M.keys = {
  -- Core Navigation
  { "<leader>ww", "<cmd>lua require('neowiki').open_wiki()<cr>",          desc = "Open Wiki" },
  { "<leader>wW", "<cmd>lua require('neowiki').open_wiki_floating()<cr>", desc = "Open Wiki (Float)" },
  { "<leader>wT", "<cmd>lua require('neowiki').open_wiki_new_tab()<cr>",  desc = "Open Wiki (Tab)" },
}

M.opts = {
  wiki_dirs = {
    { name = "Work", path = "~/vimwiki" },
  },
}

return M
