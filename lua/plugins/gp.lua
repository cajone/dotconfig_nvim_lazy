M = {
  "robitx/gp.nvim",
  config = function()
    local conf = {
      providers = {
        ollama = {
          disable = true,
          endpoint = "http://localhost:11434/v1/chat/completions",
          secret = "dummy_secret",
        },
        agents = {
          provider = "ollama",
          name = "llama3.2",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = {
            model = "llama3.1",
            temperature = 0.6,
            top_p = 1,
            min_p = 0.05,
          },
        },
        -- system prompt (use this to specify the persona/role of the AI)
        system_prompt = "You are a general AI assistant.",
      },
    }
    -- For customization, refer to Install > Configuration in the Documentation/Readme
    require("gp").setup(conf)

    -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
  end,
}
return M
