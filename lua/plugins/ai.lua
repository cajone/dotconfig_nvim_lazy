M = {
  "David-Kunz/gen.nvim",
  opts = {
    model = "qwen2.5-coder:14b", -- Set default model to an empty string
    host = "localhost",
    port = "3000",
    --      init = function(options)
    --        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    --      end,
    -- Function to initialize Ollama
    command = function(options)
      local body = { model = options.model, stream = true }
      return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    end,
    display_mode = "float",
  },
  config = function()
    local gen_prompts = {
      {
        name = "qwen23",
        model = "qwen2.5-coder:14b",
        prompt_template = "You are a senior Lua engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text",
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
}
return M
