local M = {
  "echaya/neowiki.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
  },
  init = function()
    -- Your Toggle Function (Modernized)
    _G.ToggleWikiConceal = function()
      local level = vim.opt_local.conceallevel:get()
      if level == 0 then
        vim.opt_local.conceallevel = 2
        print("Conceal: ON")
      else
        vim.opt_local.conceallevel = 0
        print("Conceal: OFF")
      end
    end

    -- Create an Autocmd to set defaults for wiki/markdown files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "neowiki" },
      callback = function()
        vim.opt_local.conceallevel = 2
        -- Keybind to toggle concealment while in a wiki file
        vim.keymap.set("n", "<leader>tc", _G.ToggleWikiConceal, { buffer = true, desc = "Toggle Wiki Conceal" })
      end,
    })
  end,
  config = function(_, opts)
    require("neowiki").setup(opts)
    require("render-markdown").setup({
      -- This tells the renderer to squash the [Label](URL) into just [Label]
      link = {
        enabled = true,
        render_mode = "compact",
      },
    })
  end,

  keys = {
    { "<leader>ww", "<cmd>lua require('neowiki').open_wiki()<cr>",          desc = "Open Wiki" },
    { "<leader>wW", "<cmd>lua require('neowiki').open_wiki_floating()<cr>", desc = "Open Wiki (Float)" },
    { "<leader>wT", "<cmd>lua require('neowiki').open_wiki_new_tab()<cr>",  desc = "Open Wiki (Tab)" },
  },

  opts = {
    wiki_dirs = { { name = "Work", path = "~/vimwiki" } },
  },
}

return M
