M = {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- CHANGE: Use npm to install the mcp-hub binary globally
  build = "npm install -g mcp-hub@latest",

  config = function()
    require("mcphub").setup({
      -- Ensure the config path is still specified (it's correct)
      config = vim.fn.expand("~/.config/mcphub/servers.json"),

      -- CHANGE: Set to false to use the globally installed npm binary
      use_bundled_binary = false,

      -- Keep the logging for debugging; it will help if there are new errors
      log = {
        level = vim.log.levels.DEBUG, -- Set to DEBUG for more verbose logs
        to_file = true,
        file_path = vim.fn.expand("~/.config/mcphub/mcphub_debug.log"),
      },
      -- You can also add other options from the official example if desired,
      -- such as mcp_request_timeout, auto_approve, etc.
      -- port = 37373, -- This is the default, so often not needed
    })
  end,
}
return M
