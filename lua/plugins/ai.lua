local M = {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "dolphin-mixtral:8x7b-v2.5-q5_K_M", -- Set default model to an empty string
    },
    config = function()
      local gen_prompts = {
        { name = "Agen", model = "mistral", prompt_template = "$input\n$text" },

        { name = "Amix", model = "dolphin-mixtral",
          prompt_template = "[[You are a senior AI engineer, answering questions about LLMs, AI frameworks. Focus should be on solutions that running LLM's locally $input\n$text]]"
        },

        { name = "Bmix", model = "dolphin-mixtral:8x7b-v2.5-q5_K_M",
          prompt_template = "[[You are a story teller that focuses on detail and scene setting $input\n$text]]",
          temperature = 1.5
        },

        { name = "Lua",
          model = "deepseek-coder:6.7b",
          prompt_template = "[[You are a senior Lua engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text]]",
        },


        { name = "Inspec",
          model = "orca2",
          prompt_template = "[[You are a senior Quality Assurance engineer, answer questions about Chef Inspec testing. Provide code examples where appropriate. $input\n$text]]",
        },

        { name = "phi",
          model = "phi",
          prompt_template = "[[You are a senior software engineer, answering questions. Do not generate anything but the code $input\n$text]]",
        },


        { name = "pi",
          model = "codellama:python",
          prompt_template = "[[You are a senior Python engineer, answering questions about Python. Do not generate anything but the code $input\n$text]]",
        },

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
