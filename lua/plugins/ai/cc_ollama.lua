-- ~/.config/pvim/lua/plugins/ai/cc_ollama.lua
-- This file defines the setup for your forked CodeCompanion (cc_ollama.nvim)
-- and its integration with Ollama and mcphub.nvim.
-- It is designed to be imported by your main Lazy.nvim configuration.

-- IMPORTANT: NO 'require("codecompanion.*")' calls at this top level.
-- These modules become fully available only after CodeCompanion's 'setup' function runs.

local M = {
  -- IMPORTANT: Point Lazy.nvim to your GitHub fork and specify the 'cleanup' branch.
  -- This ensures Lazy.nvim fetches your specific version of the plugin.
  "cajone/cc_ollama.nvim",
  branch = "cleanup",

  -- Configuration options for CodeCompanion
  opts = {
    log_level = "debug", -- Set to "debug" for verbose output during troubleshooting

    -- Adapters are now expected to be defined within the forked plugin's own
    -- `lua/codecompanion/config.lua` or directly in `lua/codecompanion/adapters/ollama.lua`.
    -- Your `ollama.lua` in ~/git/cc_ollama/lua/codecompanion/adapters/ollama.lua
    -- should define the adapter with its schema, including the 'stream' option.
    -- The main plugin config here just needs to refer to it by name.
    adapters = {
      -- We explicitly define 'ollama = nil'. CodeCompanion's `setup` will then
      -- discover and register the adapter based on its definition in your forked plugin.
      ollama = nil,
    },

    -- Define strategies for CodeCompanion's chat, inline, and cmd interactions.
    strategies = {
      chat = {
        -- Set the primary LLM adapter for the chat strategy to "ollama".
        adapter = "ollama",
        -- 'provider' is also set to "ollama" for consistency.
        provider = "ollama",

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
      -- Explicitly define the 'inline' strategy.
      inline = {
        adapter = "ollama", -- Use Ollama for inline strategy
        provider = "ollama", -- Keep provider for consistency
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            index = 1,
            callback = "keymaps.accept_change",
            description = "Accept change",
          },
          reject_change = {
            modes = { n = "gr" },
            index = 2,
            callback = "keymaps.reject_change",
            description = "Reject change",
          },
        },
        variables = {
          ["buffer"] = {
            callback = "strategies.inline.variables.buffer",
            description = "Share the current buffer with the LLM",
            opts = { contains_code = true },
          },
          ["chat"] = {
            callback = "strategies.inline.variables.chat",
            description = "Share the currently open chat buffer with the LLM",
            opts = { contains_code = true },
          },
          ["clipboard"] = {
            callback = "strategies.inline.variables.clipboard",
            description = "Share the contents of the clipboard with the LLM",
            opts = { contains_code = true },
          },
        },
        opts = {
          blank_prompt = "", -- The prompt to use when the user doesn't provide a prompt
          -- These will be assigned after CodeCompanion's setup, by retrieving modules.
          completion_provider = nil,
          register = "+",
          yank_jump_delay_ms = 400,
          goto_file_action = nil,
        },
      },
      -- Explicitly define the 'cmd' strategy.
      cmd = {
        adapter = "ollama", -- Use Ollama for cmd strategy
        provider = "ollama", -- Keep provider for consistency
        opts = {
            system_prompt = [[You are currently plugged in to the Neovim text editor on a user's machine. Your core task is to generate an command-line inputs that the user can run within Neovim. Below are some rules to adhere to:

- Return plain text only
- Do not wrap your response in a markdown block or backticks
- Do not use any line breaks or newlines in you response
- Do not provide any explanations
- Generate an command that is valid and can be run in Neovim
- Ensure the command is relevant to the user's request]],
        },
      },
    },

    -- Configuration for CodeCompanion extensions (like MCPHub)
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion", -- Link to the MCPHub extension's callback
        opts = {
          make_vars = true,           -- Generate context variables from MCP resources
          make_slash_commands = true, -- Enable slash commands like `/mcp`
          show_result_in_chat = true  -- Display tool execution results in chat
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
      build = "npm install", -- This build step is for mcphub.nvim itself.
      config = function()
        require("mcphub").setup({
          port = 4000,                                -- MCP Hub server port
          host = "localhost",                         -- MCP Hub server host
          config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Path to server definitions
          use_bundled_binary = false,                 -- Use global `mcp-hub`
          log = {
            level = vim.log.levels.DEBUG,             -- Enable debug logging for mcphub
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

    -- Now, CodeCompanion's internal modules are available.
    local adapters_module = require("codecompanion.adapters")
    local providers = require("codecompanion.providers")
    local ui_utils = require("codecompanion.utils.ui")

    -- Assign the required modules to the opts table properties for the inline strategy
    -- These were previously defined as nil placeholders and now get their actual values.
    opts.strategies.inline.opts.completion_provider = providers.completion
    opts.strategies.inline.opts.goto_file_action = ui_utils.tabnew_reuse

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
