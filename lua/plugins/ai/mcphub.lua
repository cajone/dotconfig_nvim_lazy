-- Your Neovim config file (e.g., lua/plugins.lua)
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
          -- If you built your custom image named 'mcphub-mcp-time-server', use that:
          -- args = {"run", "-p", "8001:8000", "-i", "--rm", "mcphub-mcp-time-server"}
        },
      },
      use_bundled_binary = true,

      -- >>> REMOVE OR COMMENT OUT THIS LINE <<<
      -- config = vim.fn.expand("~/.config/mcphub/servers.json"),

      log = {
        level = vim.log.levels.DEBUG,
        to_file = true,
        file_path = vim.fn.expand("~/.config/mcphub/mcphub_debug.log"),
      },
    })
  end,
}
return M
