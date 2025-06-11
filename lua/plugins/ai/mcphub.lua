-- ~/.config/nvim/lua/plugins/mcphub.lua (or wherever your mcphub.nvim config lives)

local M = {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim", -- Keep this if you use Telescope for plugin integration
  },
  -- Remove the 'build = "bundled_build.lua"' line. We installed mcp-hub globally via npm.
  config = function()
    require("mcphub").setup({
      native_servers = {},
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },
      -- REQUIRED: Tell mcphub.nvim which port to connect to your running mcp-hub backend
      port = 4000,
      host = "localhost", -- It's good practice to explicitly state the host

      -- This line correctly tells mcphub.nvim to load server definitions
      -- from the specified JSON file. These servers will be managed by mcp-hub.
      config = vim.fn.expand("~/.config/mcphub/servers.json"),

      -- Set to false because we're using a globally installed mcp-hub via npm,
      -- not a binary bundled with the Neovim plugin.
      use_bundled_binary = false,

      -- You might need to explicitly define the command path for mcp-hub
      -- if Neovim's PATH doesn't reliably pick it up.
      -- If `:MCPHub` still doesn't find the servers, uncomment these lines and ensure path is correct:
      -- cmd = vim.fn.expand("~/.npm-global/bin/mcp-hub"),
      -- cmd_args = { "--port", "4000", "--config", vim.fn.expand("~/.config/mcphub/servers.json") },


      -- Your LLM provider config. This is fine.
      default_llm_provider = "ollama",

      log = {
        level = vim.log.levels.DEBUG,
        to_file = true,
        file_path = vim.fn.expand("~/.config/mcphub/mcphub_debug.log"),
      },
    })
  end,
}

return M
