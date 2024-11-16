M = {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_restore_enabled = true,
      bypass_session_save_filetypes = { "gitcommit", "gitrebase" },
      session_lens = {
        show_preview = false, -- or true if you like previews
        path_display = { "shorten" }, -- display paths in a shortened form (e.g., '~/project1')
      },
      on_session_restore = function()
        print("Session restored!")
      end,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop" },
    })

    -- Optional: Create a command to clean up old session files
    vim.api.nvim_create_user_command("SessionCleanup", function()
      local session_dir = vim.fn.stdpath("data") .. "/sessions/"
      for _, file in ipairs(vim.fn.glob(session_dir .. "*.vim", false, true)) do
        if vim.fn.getftime(file) + 86400 * 30 < os.time() then -- older than 30 days
          vim.fn.delete(file)
        end
      end
    end, {})
  end,
}
return M
