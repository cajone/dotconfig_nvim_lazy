M = {
  "olimorris/codecompanion.nvim",
  opts = {
    -- This is a very basic example; you'd typically want to integrate these
    -- into your overall keymapping strategy (e.g., with 'which-key.nvim')
    -- or define them globally outside of `opts`.
    -- For demonstration, let's put them here.
    mappings = {
      -- Open/Toggle the main chat window
      -- This example uses <leader>cc (leader-c-c)
      open_chat = "<leader>cc",
      -- Clear the chat history
      clear_chat = "<leader>cz",
      -- Send current selection as context (e.g., in visual mode)
      send_selection = "<leader>cs",
      -- Automatically apply a prompt to the selection (e.g., "refactor")
      -- You would define specific command mappings for this
      -- For example, to refactor visually selected code:
      -- vmap <leader>cr <Plug>(CodeCompanionRefactor)
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  -- If using lazy.nvim, you might put mappings here:
  config = function(_, opts)
    require("codecompanion").setup(opts)
    -- Setup custom mappings here
    vim.keymap.set("n", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion: Open Chat" })
    vim.keymap.set("n", opts.mappings.clear_chat, "<cmd>CodeCompanionClear<CR>", { desc = "CodeCompanion: Clear Chat" })
    vim.keymap.set("v", opts.mappings.send_selection, "<cmd>CodeCompanionSelection<CR>",
      { desc = "CodeCompanion: Send Selection" })
    -- ... more specific mappings
  end,
}
return M
