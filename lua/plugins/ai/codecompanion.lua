M = {
  "olimorris/codecompanion.nvim",
  opts = {
    -- === ADD THIS LINE ===
    provider = "mcphub",
    -- =====================
    mappings = {
      -- Open/Toggle the main chat window in Normal mode
      open_chat = "<leader>cc",
      -- Clear the chat history
      clear_chat = "<leader>cz",
      -- Send current selection as context (e.g., in visual mode)
      send_selection = "<leader>cs",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)

    -- Setup custom mappings here
    vim.keymap.set("n", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion: Open Chat" })
    vim.keymap.set("n", opts.mappings.clear_chat, "<cmd>CodeCompanionClear<CR>", { desc = "CodeCompanion: Clear Chat" })

    -- Visual mode mapping: Opens chat and implicitly uses current selection as context
    vim.keymap.set("v", opts.mappings.send_selection, "<cmd>CodeCompanion<CR>",
      { desc = "CodeCompanion: Open Chat with Selection Context" })

    -- Visual mode mapping for <leader>cc: Also opens chat and implicitly uses selection.
    vim.keymap.set("v", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>",
      { desc = "CodeCompanion: Open Chat (from Visual mode)" })
  end,
}

return M
