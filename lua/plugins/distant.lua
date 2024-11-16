M = {
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    config = function()
      require("distant").setup({
        log = {
          level = "error", -- or "info", "debug"
          file = vim.fn.stdpath("data") .. "/log/distant.log",
        },
        capabilities = {
          edit = true,
          exec = false, -- Disable remote execution if not needed
        },
      })

      -- Optional: Add error handling for connection issues
      local function handle_error(err)
        print("Distant Error: " .. err.message)
      end

      require("distant").on_error(handle_error)

      -- Define custom key mappings
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rd",
        ":lua require('distant').connect({ host = 'your.remote.server', port = 22, user = 'username' })<CR>",
        { desc = "Connect to Remote Server" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rr",
        ":lua require('distant').disconnect()<CR>",
        { desc = "Disconnect from Remote Server" }
      )
    end,
  },
}
return M
