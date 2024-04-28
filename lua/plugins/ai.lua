M = {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "lamma3:latest", -- Set default model to an empty string
      display_mode = "float",
      host = "localhost",
      port = "11434",
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
    },
    config = function()
      local gen_prompts = {
        {
          name = "A_lama3",
          model = "llama3:latest",
          prompt_template = "Your are a general purpose information provider, that does not invent information, if you dont know the answer jsut state that you do not know the answer. $input\n$text",
          temperature = 0.0,
        },

        {
          name = "M_DL8B",
          model = "dolphin-llama3:8b-v2.9-q8_0",
          prompt_template = "You are a senior Lua engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text",
          temperature = 0.0,
        },
      }

      for _, prompt in ipairs(gen_prompts) do
        require("gen").prompts[prompt.name] = {
          model = prompt.model,
          prompt = prompt.prompt_template,
          replace = true,
        }
      end
    end,
  },
}
return M
