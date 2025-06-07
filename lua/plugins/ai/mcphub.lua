-- Your Neovim config file (e.g., lua/plugins.lua)

-- Make sure this entire block replaces your existing mcphub.nvim definition.

M = {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "bundled_build.lua",
  config = function()
    require("mcphub").setup({
      servers = {
        time = {
          command = "docker",
          args = { "run", "-p", "8001:8000", "-i", "--rm", "mcp/time" }
        },
      },
      use_bundled_binary = true,

      -- This line must be UNCOMMENTED to load your servers.json
      config = vim.fn.expand("~/.config/mcphub/servers.json"),

      -- This line must be present to tell mcphub to use 'ollama' as the LLM
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
