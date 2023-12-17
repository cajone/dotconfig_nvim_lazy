local M = {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "", -- Set default model to an empty string
    },
    config = function()
      local gen_prompts = {
        { name = "Agen", model = "mistral", prompt_template = "$input\n$text" },

        { name = "Lua",
          model = "deepseek-coder:6.7b",
          prompt_template = "[[You are a senior Lua engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text]]",
        },


        { name = "Inspec",
          model = "orca2",
          prompt_template = "[[You are a senior Quality Assurance engineer using the test framework inspec, answer questions about inspec. Provide code examples where appropriate. $input\n$text]]",
        },


        { name = "pi",
          model = "codellama:python",
          prompt_template = "[[You are a senior Python engineer, answering questions about Python. Do not generate anything but the code $input\n$text]]",
        },


        { name = "General", model = "mistral", prompt_template = "[[You are a senior AI engineer, answering questions about LLMs, AI frameworks. $input\n$text]]" },
      }

      for _, prompt in ipairs(gen_prompts) do
        require('gen').prompts[prompt.name] = {
          model = prompt.model,
          prompt = prompt.prompt_template,
          replace = true
        }
      end
    end
  }
} return M

--   prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
