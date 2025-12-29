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
          -- Ghost Text Mappings (Standard Suggestions)
          accept = "<Tab>",      -- desc: "Accept suggestion"
          accept_word = "<M-w>", -- desc: "Accept next word (Alt + W)"
          accept_line = "<M-l>", -- desc: "Accept next line (Alt + L)"
          next = "<M-]>",        -- desc: "Cycle to next suggestion"
          prev = "<M-[>",        -- desc: "Cycle to previous suggestion"
          dismiss = "<C-]>",     -- desc: "Hide the suggestion"
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
      -- CHAT INTERNAL MAPPINGS (Extrapolated from README)
      mappings = {
        complete = { insert = "<Tab>", desc = "Token completion menu" },
        close = { normal = "q", insert = "<C-c>", desc = "Close chat window" },
        reset = { normal = "<C-l>", insert = "<C-l>", desc = "Reset/Clear chat window" },
        submit_prompt = { normal = "<CR>", insert = "<C-s>", desc = "Submit the current prompt" },
        accept_diff = { normal = "<C-y>", insert = "<C-y>", desc = "Accept nearest diff" },
        show_diff = { normal = "gd", desc = "Show diff with source" },
        yank_diff = { normal = "gy", desc = "Yank diff to register" },
        goto_diff = { normal = "gj", desc = "Jump to diff section" },
        show_help = { normal = "gh", desc = "Show help message" },
      },
      window = {
        layout = "float",
        width = 0.8,
        height = 0.7,
        border = "rounded",
      },
      -- Predefined Custom Prompts
      prompts = {
        LuaConfig = {
          prompt = "You are a Lua expert. Help me refactor this Neovim configuration: #selection",
          system_prompt = "You are a world-class Neovim configuration expert.",
        },
        DevOpsCheck = {
          prompt = "Review this for DevOps best practices (idempotency, error handling): #selection",
          system_prompt = "You are a Senior DevOps Engineer.",
        },
      },
    },
    keys = {
      -- EXTERNAL TRIGGER KEYS (Leader-based shortcuts)
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", mode = { "n", "x" }, desc = "CopilotChat - Toggle" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>",  mode = { "n", "x" }, desc = "CopilotChat - Reset Chat" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>",    mode = { "n", "x" }, desc = "CopilotChat - Fix Selection" },
      {
        "<leader>cy",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Action Picker",
      },
      {
        "<leader>ca",
        function()
          local chat = require("CopilotChat")
          -- Forcefully apply the nearest code block from the chat to the active file
          chat.apply_diff()
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Automate Apply Diff",
      },

      -- Jump to Diff (Bypasses the gj error)
      {
        "<leader>cj",
        function()
          require("CopilotChat").jump_to_diff()
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Jump to Diff",
      },
    },
  },
}

return M
