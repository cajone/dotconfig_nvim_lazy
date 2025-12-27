local M = {
  "echaya/neowiki.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  init = function()
    -- Global settings
    vim.opt.conceallevel = 2
    vim.opt.concealcursor = "nc"

    -- Ensure these settings stick specifically for markdown files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "neowiki" },
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "nc"
      end,
    })
  end,
  opts = {
    wiki_dirs = {
      { name = "Work", path = "~/vimwiki" },
    },
  },
  -- Configure render-markdown to force concealment
  config = function(_, opts)
    require("neowiki").setup(opts)
    require("render-markdown").setup({
      link = {
        -- This is the key setting to hide the (https://...) part
        enabled = true,
        render_mode = "compact", -- Hides the URL and brackets
      },
      -- Some colorschemes override conceal highlights; force it here if needed
      conceal = {
        enabled = true,
      },
    })
  end,
  keys = {
    { "<leader>ww", "<cmd>lua require('neowiki').open_wiki()<cr>",          desc = "Open Wiki" },
    { "<leader>wW", "<cmd>lua require('neowiki').open_wiki_floating()<cr>", desc = "Open Wiki in Floating Window" },
    { "<leader>wT", "<cmd>lua require('neowiki').open_wiki_new_tab()<cr>",  desc = "Open Wiki in Tab" },
  },
}

return M
