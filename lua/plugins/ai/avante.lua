local M = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  -- 'version = false' is a note, not a config item for lazy.nvim, so it's omitted
  opts = {
    provider = "ollama",                     -- Define your primary provider here
    providers = {                            -- Configure specific providers here
      ollama = {
        endpoint = "http://localhost:11434", -- Local Ollama endpoint
        model = "devstral:latest",           -- Your desired model
        -- model = "devstral:latest",           -- Your desired model
      },
    },
    -- Removed system_prompt and custom_tools as they are not bare minimum and
    -- were related to mcphub, which you've indicated was problematic.
  },
  build = "make", -- Essential for building the plugin
  dependencies = {
    -- These are commonly required dependencies for many Neovim plugins to function
    -- correctly, especially for UI elements.
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    -- Explicitly call setup with the opts table to ensure Avante's internal config is ready
    require("avante").setup(opts)
  end,
}

return M
