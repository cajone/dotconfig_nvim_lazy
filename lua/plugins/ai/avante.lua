local M = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    require("avante").setup(opts)
  end,
  opts = {
    -- Set the default provider to your new model
    provider = "qwen3_coder_30b",

    -- Define only the necessary providers
    providers = {
      -- This is the base Ollama provider, required for the inherited model
      ollama = {
        endpoint = "http://localhost:11434",
        extra_request_body = {
          options = {
            num_tokens = 20480, -- This is the default from the plugin
            keep_alive = "5m",
          },
        },
      },

      -- Your custom model entry
      qwen3_coder_30b = {
        __inherited_from = "ollama",
        model = "qwen3-coder:30b",
      },
    },

    -- Remove all shortcuts
    shortcuts = {},
  },
}

return M
