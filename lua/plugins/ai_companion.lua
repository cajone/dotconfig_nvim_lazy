-- ~/.config/nvim/lua/plugins/ai_companion.lua
-- This file defines the setup for CodeCompanion.nvim and its dependency mcphub.nvim.
-- It should be loaded via `require("lazy").setup({ { import = "plugins.ai_companion" } })`
-- in your main Lazy.nvim configuration.

local M = {
  "olimorris/codecompanion.nvim",
  opts = {
    -- Defining the Ollama adapter directly within the 'adapters' table as per the documentation's "extending adapter" example.
    -- This is the authoritative place to configure specific adapters.
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            -- Ensure this URL is correct for your Ollama server.
            url = "http://127.0.0.1:11434",
            -- If Ollama requires an API key in the future, you would define it here:
            -- api_key = os.getenv("OLLAMA_API_KEY"), -- or "cmd:your_secret_command"
          },
          -- The default model for the Ollama adapter.
          model = "qwen2.5-coder:latest",
        })
      end,
    },

    -- Defines strategies for CodeCompanion's chat and tool interactions.
    strategies = {
      chat = {
        -- Explicitly set the adapter to "ollama" for the chat strategy.
        -- This tells the 'chat' strategy to use the 'ollama' adapter defined above.
        adapter = "ollama",
        -- Removed the redundant 'provider = "ollama"' as 'adapter' takes precedence.
        -- Removed the nested 'ollama = { ... }' table from here to prevent conflicts.

        -- Dynamically injects MCP tools into the system prompt for the LLM.
        -- This will be sent to Ollama *if* the Ollama adapter is successfully loaded.
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          if hub then
            return hub:get_active_servers_prompt()
          else
            return "You are an AI programming assistant named \"CodeCompanion\". You are currently plugged into the Neovim text editor."
          end
        end,
      }
    },
    -- Configuration for CodeCompanion extensions.
    -- The `mcphub` extension is crucial for integrating MCP tools.
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,           -- Generates context variables from MCP resources
          make_slash_commands = true, -- Enables slash commands like `/mcp`
          show_result_in_chat = true  -- Displays tool execution results directly in the chat buffer
        }
      }
    },
    -- Key mappings for CodeCompanion actions.
    mappings = {
      open_chat = "<leader>cc",
      clear_chat = "<leader>cz",
      send_selection = "<leader>cs",
    },
  },
  -- Dependencies required by CodeCompanion.
  dependencies = {
    "nvim-lua/plenary.nvim",          -- Essential for asynchronous operations
    "nvim-treesitter/nvim-treesitter", -- Used by CodeCompanion for syntax highlighting and parsing
    {
      -- Configuration for mcphub.nvim, defined as a nested dependency.
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        -- "nvim-telescope/telescope.nvim", -- Uncomment if you use Telescope for mcphub.nvim integration
      },
      -- ADDED: A `build` step for `mcphub.nvim`.
      build = "npm install",
      config = function()
        require("mcphub").setup({
          port = 4000,                -- REQUIRED: Must match the port your `mcp-hub` process is listening on.
          host = "localhost",         -- Explicitly set the host.
          config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Path to your MCP server definitions.
          use_bundled_binary = false, -- Set to `false` as you're using a globally installed `mcp-hub`.
          log = {
            level = vim.log.levels.DEBUG, -- Set to DEBUG for detailed logs, INFO for normal operation.
            to_file = true,
            file_path = vim.fn.expand("~/.config/mcphub/mcphub_debug.log"), -- Path for mcphub.nvim's debug log.
          },
        })
      end,
    },
  },
  -- Main CodeCompanion setup function.
  config = function(_, opts)
    require("codecompanion").setup(opts)
    -- Setting keymaps based on the `opts.mappings` table.
    vim.keymap.set("n", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion: Open Chat" })
    vim.keymap.set("n", opts.mappings.clear_chat, "<cmd>CodeCompanionClearChat<CR>", { desc = "CodeCompanion: Clear Chat" })
    vim.keymap.set("v", opts.mappings.send_selection, "<cmd>CodeCompanion<CR>",
      { desc = "CodeCompanion: Open Chat with Selection Context" })
    vim.keymap.set("v", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>",
      { desc = "CodeCompanion: Open Chat (from Visual mode)" })
  end,
}

return M

