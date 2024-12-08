M = {
  "cajone/gp.nvim",
  lazy = false,
  config = function()
    require("gp").setup({
      -- log file location
      log_file = vim.fn.stdpath("log"):gsub("/$", "") .. "~/Documents/gp/gp.nvim.log",
      -- directory for persisting state dynamically changed by user (like model or persona)
      state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "~/Documents/gp/persisted",

      default_chat_agent = 'qwen',

      providers = {
        ollama = {
          endpoint = "http://localhost:11434/v1/chat/completions",
        },
      },
      agents = {
        {
          name = "Llama3.2",
          chat = true,
          command = true,
          provider = "ollama",
          model = { model = "llama3.2:latest" },
          system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
            .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
            .. "and expect precise, technical responses tailored to your development needs.\n",
        },
        {
          name = "qwen32",
          chat = true,
          command = true,
          provider = "ollama",
          model = { model = "qwen2.5-coder:32b" },
          system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
            .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
            .. "and expect precise, technical responses tailored to your development needs.\n",
        },
        {
          name = "qwq",
          chat = true,
          command = true,
          provider = "ollama",
          model = { model = "qwq:latest" },
          system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
            .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
            .. "and expect precise, technical responses tailored to your development needs.\n",
        },
      },
      hooks = {
        -- example of using enew as a function specifying type for the new buffer
        UnitTests = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by writing table driven unit tests for the code above."
          local agent = gp.get_command_agent()
          gp.Prompt(params, gp.Target.vnew, agent, template)
        end,

        CodeReview = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please analyze for code smells and suggest improvements."
          local agent = gp.get_chat_agent()
          gp.Prompt(params, gp.Target.vnew, agent, template)
        end,
        -- example of making :%GpChatNew a dedicated command which
        -- opens new chat with the entire current buffer as a context
        BufferChatNew = function(gp, _)
          -- call GpChatNew command in range mode on whole buffer
          vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
        end,
      },
    })
  end,
}

return M
