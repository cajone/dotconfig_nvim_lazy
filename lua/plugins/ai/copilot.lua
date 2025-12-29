local M = {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = false,
            accept_word = "<M-w>",
            accept_line = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      })

      -- SMART TAB: Accept suggestion if visible, else insert tab
      vim.keymap.set("i", "<Tab>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { desc = "Copilot: Accept or Tab", silent = true })
    end,
  },

  -- Copilot Chat Integration
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      mappings = {
        complete = { insert = "<Tab>" },
        close = { normal = "q", insert = "<C-c>" },
        reset = { normal = "<C-l>", insert = "<C-l>" },
        submit_prompt = { normal = "<CR>", insert = "<C-s>" },
        accept_diff = { normal = "<C-y>", insert = "<C-y>" },
        show_diff = { normal = "gd" },
        yank_diff = { normal = "gy" },
        goto_diff = { normal = "gj" },
        show_help = { normal = "gh" },
      },
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
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", mode = { "n", "x" }, desc = "CopilotChat - Toggle" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>",  mode = { "n", "x" }, desc = "CopilotChat - Reset Chat" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>",    mode = { "n", "x" }, desc = "CopilotChat - Fix Selection" },
      {
        "<leader>ca",
        function()
          require("CopilotChat").apply_diff()
        end,
        mode = { "n", "x" },
        desc = "CopilotChat - Automate Apply Diff",
      },
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
