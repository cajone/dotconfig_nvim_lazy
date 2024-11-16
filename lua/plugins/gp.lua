M = {
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        providers = {
          ollama = {
            endpoint = "http://localhost:3000/v1/chat/completions",
            secret = nil,
            log_level = "debug", -- Example of enabling debug logging
          },
        },
        agents = {
          ollama = {
            chat = true,
            command = false,
            model = {
              name = "qwen2.5-coder:14b",
              temperature = 0.6,
              top_p = 1,
              min_p = 0.05,
            },
          },
        },
        system_prompt = "You are an experienced software developer.",
      }

      require("gp").setup(conf)

      vim.api.nvim_set_keymap("n", "<leader>llm", ":GPChat<CR>", { desc = "Start AI Chat" })
      vim.api.nvim_set_keymap("v", "<leader>llc", ":'<,'>GPExecute<CR>", { desc = "Execute Selection with AI" })
    end,
  },
}
return M
