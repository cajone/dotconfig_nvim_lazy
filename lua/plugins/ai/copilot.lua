local M = {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",      -- This is what you're looking for!
          accept_word = "<M-w>", -- Accept only the next word (Alt + W)
          accept_line = "<M-l>", -- Accept only the next line (Alt + L)
          next = "<M-]>",        -- Cycle to next suggestion
          prev = "<M-[>",        -- Cycle to previous suggestion
          dismiss = "<C-]>",     -- Hide the suggestion
        },
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      window = {
        layout = "float",
        width = 0.8,
        height = 0.7,
        border = "rounded",
      },
      prompts = {
        LuaConfig = {
          prompt = "You are a Lua expert. Help me refactor this Neovim configuration: #selection",
          system_prompt = "You are a world-class Neovim configuration expert.",
        },
        DevOpsCheck = {
          prompt = "Review this for DevOps best practices (idempotency, error handling): #selection",
          system_prompt = "You are a Senior DevOps Engineer.",
        },
        PythonExpert = {
          prompt = "You are a Python expert. Help me improve this Python code: #selection",
          system_prompt = "You are a world-class Python developer.",
        },
      },
    },
    keys = {
      -- Open/Toggle Chat (Now works in Normal and Visual mode)
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", mode = { "n", "x" }, desc = "CopilotChat - Toggle" },

      -- Action Picker (Telescope)
      {
        "<leader>cy",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Action Picker",
      },

      -- Apply Diff directly
      {
        "<leader>ca",
        "<cmd>CopilotChatApply<cr>",
        mode = { "n", "x" },
        desc = "CopilotChat - Apply Diff",
      },

      -- Fix current selection
      {
        "<leader>cf",
        "<cmd>CopilotChatFix<cr>",
        mode = { "n", "x" },
        desc = "CopilotChat - Fix Selection",
      },

      -- Reset Chat
      {
        "<leader>cr",
        "<cmd>CopilotChatReset<cr>",
        mode = { "n", "x" },
        desc = "CopilotChat - Reset Chat",
      },
    },
  },
}

return M
