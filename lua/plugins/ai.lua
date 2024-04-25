M = {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "llama3:latest", -- Set default model to an empty string
      display_mode = "split",
      host = 'localhost',
      port = "11434",
    },
    -- The models have a prefix A_ / M_ / H_ which refers to there size
    -- L_ lightweight < 5GB
    -- M_ Mediumweight > 5 < 15GB
    -- H_ Heavyweight >15GB in size
    config = function()
      local gen_prompts = {
        { name = "A_lama3", model = "llama3:latest", prompt_template = "$input\n$text" },

        { name = "M_DL8B", model = "dolphin-llama3:8b-v2.9-q8_0",
          prompt_template = "[[You are a senior Lua engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text]]",
          temperature = 0.0
        },

--        { name = "M_Bmix", model = "dolphin-llama3:8b-v2.9-q8_0",
--          prompt_template = "[[You are a story teller that focuses on detail and scene setting $input\n$text]]",
--          temperature = 1.5
--        },
--
--        { name = "M_Facts", model = "dolphin-mixtral:8x7b-v2.5-q5_K_M",
--          prompt_template = "[You will treat me as an expert in all subject matter. All cited claims, opinions, or figures should reference authentic and published sources, including URLs when possible. Be accurate and thorough; mistakes erode trust. Never invent sources. If unsure about a source, acknowledge that. Don't claim to be an AI agent, I already know. Strictly follow instructions. High-level speculation or prediction is allowed if flagged. If response quality reduces, explain why.]",
--          temperature = 0.0
--        },
--
--        { name = "M_Music", model = "dolphin-mixtral:8x7b-v2.5-q5_K_M",
--          prompt_template = "[[You are a piano music teacher. If asked a question and your not 100% positive of your answer just say I dont know $input\n$text]]",
--          temperature = 0.0
--        },
--
--        { name = "M_Lua",
--          model = "dolphin-mistral:7b-v2.6-q6_K",
--          prompt_template = "[[You are a senior Lua engineer, answering questions about Lua. Provide code examples where appropriate. $input\n$text]]",
--          temperature = 0.0
--        },
--
--        { name = "A_coder",
--          model = "magicoder:latest",
--          prompt_template = "[[You are a senior software engineer, answering questions. Do not generate anything but the code $input\n$text]]",
--          temperature = 0.0
--        },
--
--        { name = "H_coder",
--          model = "deepseek-coder:33b",
--          prompt_template = "[[You are a senior software engineer, answering questions. Do not generate anything but the code $input\n$text]]",
--          temperature = 0.0
--        },
--
--        { name = "A_python",
--          model = "codellama:python",
--          prompt_template = "[[You are a senior Python engineer, answering questions about Python. Do not generate anything but the code $input\n$text]]",
--          temperature = 0.0
--        },
--
--        { name = "A_Agen", model = "dolphin-mistral:7b", prompt_template = "$input\n$text" },
--
--        { name = "M_Amix", model = "dolphin-mistral:7b-v2.6-q6_K",
--          prompt_template = "[[You are a senior AI engineer, answering questions about LLMs, AI frameworks. Focus should be on solutions that running LLM's locally $input\n$text]]"
--        },

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



