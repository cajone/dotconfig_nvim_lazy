-- ~/.config/nvim/lua/plugins/ai/cc_ollama.lua
-- This file defines the setup for your forked CodeCompanion (cc_ollama.nvim)
-- and its integration with Ollama and mcphub.nvim.
-- It is designed to be imported by your main Lazy.nvim configuration.

local M = {
  -- IMPORTANT: Point Lazy.nvim to your GitHub fork and specify the 'cleanup' branch.
  "cajone/cc_ollama.nvim",
  branch = "cleanup", -- This tells Lazy.nvim to use your 'cleanup' branch

  -- Configuration options for CodeCompanion
  opts = {
    log_level = "debug", -- Set to "debug" for verbose output during troubleshooting

    -- REMOVED: The 'adapters' table at this level was causing persistent
    -- 'expected table, got string' errors due to deep merging conflicts
    -- with CodeCompanion's internal default adapter definitions.
    -- Adapter configuration is now handled directly within the 'strategies.chat' block.
    -- adapters = {
    --   ollama = {
    --     model = "qwen2.5-coder:latest",
    --     env = {
    --       url = "http://localhost:11434",
    --     },
    --   },
    -- },

    -- Define chat strategies (how CodeCompanion interacts with LLMs)
    strategies = {
      chat = {
        -- Set the primary LLM provider for the chat strategy to "ollama".
        provider = "ollama",

        -- Define Ollama-specific options here, nested under the 'ollama' key.
        -- This is the correct and most robust way to specify the model.
        ollama = {
          model = "qwen2.5-coder:latest", -- Your preferred Ollama model
          -- You can also specify the URL here if it differs from Ollama's default (http://localhost:11434)
          -- url = "http://localhost:11434",
        },

        -- System prompt dynamically includes MCP tools
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          if hub then
            return hub:get_active_servers_prompt()
          else
            -- Fallback system prompt if mcphub is not ready
            return
            "You are an AI programming assistant named \"CodeCompanion\". You are currently plugged into the Neovim text editor."
          end
        end,
      },
    },

    -- Configuration for CodeCompanion extensions (like MCPHub)
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion", -- Link to the MCPHub extension's callback
        opts = {
          make_vars = true,                           -- Generate context variables from MCP resources
          make_slash_commands = true,                 -- Enable slash commands like `/mcp`
          show_result_in_chat = true                  -- Display tool execution results in chat
        },
      },
    },

    -- Key mappings for CodeCompanion actions
    mappings = {
      open_chat = "<leader>cc",
      clear_chat = "<leader>cz",
      send_selection = "<leader>cs",
    },
  },

  -- Dependencies required by CodeCompanion
  dependencies = {
    "nvim-lua/plenary.nvim",           -- Essential for async operations and HTTP requests
    "nvim-treesitter/nvim-treesitter", -- Used for syntax highlighting and parsing
    {
      -- mcphub.nvim plugin definition
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      -- Build step for mcphub.nvim's Node.js dependencies
      build = "npm install",
      config = function()
        require("mcphub").setup({
          port = 4000,                                             -- MCP Hub server port
          host = "localhost",                                      -- MCP Hub server host
          config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Path to server definitions
          use_bundled_binary = false,                              -- Use global `mcp-hub`
          log = {
            level = vim.log.levels.DEBUG,                          -- Enable debug logging for mcphub
            to_file = true,
            file_path = vim.fn.expand("~/.config/mcphub/mcphub_debug.log"),
          },
        })
      end,
    },
  },

  -- Main CodeCompanion setup function (executed after plugin loaded)
  config = function(_, opts)
    require("codecompanion").setup(opts)
    -- Set up keymaps
    vim.keymap.set("n", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion: Open Chat" })
    vim.keymap.set("n", opts.mappings.clear_chat, "<cmd>CodeCompanionClearChat<CR>",
      { desc = "CodeCompanion: Clear Chat" })
    vim.keymap.set("v", opts.mappings.send_selection, "<cmd>CodeCompanion<CR>",
      { desc = "CodeCompanion: Open Chat with Selection Context" })
    vim.keymap.set("v", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>",
      { desc = "CodeCompanion: Open Chat (from Visual mode)" })
  end,
}

return M
