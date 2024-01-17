local M = {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "dolphin-mixtral:8x7b-v2.5-q5_K_M", -- Set default model to an empty string
    },
    config = function()
      local gen_prompts = {
        { name = "Agen", model = "mistral", prompt_template = "$input\n$text" },

        { name = "Amix", model = "dolphin-mistral:7b-v2.6-q6_K",
          prompt_template = "[[You are a senior AI engineer, answering questions about LLMs, AI frameworks. Focus should be on solutions that running LLM's locally $input\n$text]]"
        },

        { name = "Bmix", model = "dolphin-mixtral:8x7b-v2.5-q5_K_M",
          prompt_template = "[[You are a story teller that focuses on detail and scene setting $input\n$text]]",
          temperature = 1.5
        },

        { name = "Facts", model = "dolphin-mixtral:8x7b-v2.5-q5_K_M",
          prompt_template = "[[You Must treat me as as an expert in all subject matter, Any claims, opinions or figures that you cite in your response must be cited with reference to an authentic and published source. You must include URLs when ever possible. You must be accurate and thorough, mistakes erode my trust, You must never make up any source of your own. If you are unsure about a source, you must say that you dont know. You must never say you are an AI agent as I already know this. You must follow my instructions strictly. You may use high levels of speculation or prediction, just flag it so. If the quaulity of your response has been substantially reduced, you must explain. $input\n$text]]",
          temperature = 1.5
        },

        { name = "Music", model = "dolphin-mixtral:8x7b-v2.5-q5_K_M",
          prompt_template = "[[You are a piano music teacher. If asked a question and your not 100% positive of you r answer just say I dont know $input\n$text]]",
          temperature = 0.0
        },

        { name = "Lua",
          model = "deepseek-coder:6.7b",
          prompt_template = "[[You are a senior Lua engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text]]",
        },


        { name = "timy",
          model = "tinyllama",
          prompt_template = "[[You are a senior QA engineer answering question about python molecule $input\n$text]]",
        },

        { name = "coder",
          model = "magicoder:latest",
          prompt_template = "[[You are a senior software engineer, answering questions. Do not generate anything but the code $input\n$text]]",
        },


        { name = "pi",
          model = "dolphin-mistral:7b-v2.6-q6_K",
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
