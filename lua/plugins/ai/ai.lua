M = {
  "David-Kunz/gen.nvim",
  opts = {
    model = "qwen2.5-coder:32b", -- Set default model to an empty string if needed
    host = "localhost",
    port = "11434",
    command = function(options)
      local body = { model = options.model, stream = true }
      return string.format("curl -sN -X POST http://%s:%s/api/chat -d '%s'",
        vim.fn.shellescape(options.host),
        vim.fn.shellescape(options.port),
        vim.fn.json_encode(body))
    end,
    display_mode = "horizontal-split",
  },
  config = function()
    local gen_prompts = {
      {
        name = "qwen23",
        model = "qwen2.5-coder:32b",
        prompt_template = [[
You are a senior Lua engineer, answering questions about Lua.
Provide code examples where appropriate. $input\n$text
]],
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
