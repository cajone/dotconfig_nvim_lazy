-- THIS IS THE COMPLETE, CORRECTED LUA CONFIGURATION BLOCK for CodeCompanion and MCPHub.
-- Please replace your *entire* existing 'olimorris/codecompanion.nvim' plugin definition with this.

M = {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        provider = "ollama",              -- IMPORTANT: Change "ollama" if you use a different LLM provider
        ollama = {
          model = "qwen2.5-coder:latest", -- <-- CHANGED TO THIS MODEL
        },
        -- Example: provider = "anthropic",
        -- Example: provider = "copilot",

        -- Dynamically injects MCP tools into the system prompt for the LLM.
        -- This works in conjunction with the 'extensions.mcphub' below.
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub:get_active_servers_prompt()
        end,

        -- THIS 'tools' TABLE IS FOR CODECOMPANION'S INTERNAL TOOL HANDLING,
        -- BUT THE PRIMARY INTEGRATION IS NOW THROUGH THE 'extensions' TABLE BELOW.
        -- Keeping it here for completeness as per previous iterations, but
        -- the 'extensions.mcphub' is the key.
        tools = {
          ["mcp"] = {
            callback = require("mcphub.extensions.codecompanion"),
            description = "Call tools and resources from the MCP Servers",
            opts = {
              requires_approval = true -- Set to 'false' for automatic tool execution (less secure)
            }
          }
        }
      }
    },
    -- === ADD THE 'extensions' TABLE HERE ===
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,           -- Generate variables from tools
          make_slash_commands = true, -- Generate slash commands (e.g., /time)
          show_result_in_chat = true  -- Display tool results directly in chat
        }
      }
    },
    -- =======================================
    mappings = {
      open_chat = "<leader>cc",
      clear_chat = "<leader>cz",
      send_selection = "<leader>cs",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        -- "nvim-telescope/telescope.nvim", -- Uncomment if you use Telescope for mcphub.nvim integration
      },
      config = function()
        require("mcphub").setup({
          port = 4000,
          host = "localhost",
          config = vim.fn.expand("~/.config/mcphub/servers.json"),
          use_bundled_binary = false,
          log = {
            level = vim.log.levels.DEBUG,
            to_file = true,
            file_path = vim.fn.expand("~/.config/mcphub/mcphub_debug.log"),
          },
        })
      end,
    },
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)
    vim.keymap.set("n", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion: Open Chat" })
    vim.keymap.set("n", opts.mappings.clear_chat, "<cmd>CodeCompanionClear<CR>", { desc = "CodeCompanion: Clear Chat" })
    vim.keymap.set("v", opts.mappings.send_selection, "<cmd>CodeCompanion<CR>",
      { desc = "CodeCompanion: Open Chat with Selection Context" })
    vim.keymap.set("v", opts.mappings.open_chat, "<cmd>CodeCompanion<CR>",
      { desc = "CodeCompanion: Open Chat (from Visual mode)" })
  end,
}

return M
