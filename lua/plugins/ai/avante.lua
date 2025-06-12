M = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,                           -- Never set this value to "*"! Never!
  opts = {
    provider = "ollama",                     -- Define your primary provider here
    providers = {                            -- Configure specific providers here
      ollama = {
        endpoint = "http://localhost:11434", -- Local Ollama endpoint
        model = "qwen3:latest",              -- Your desired model (or use gpt-4o, etc.)
      },
    },
    -- Integrated system_prompt to ensure LLM always has the latest MCP server state
    -- This function is evaluated for every message, even in existing chats
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Integrated custom_tools for Avante, preventing mcphub from being required before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
    -- RAG Service configuration for Avante
    rag_service = {
      enabled = true,                        -- Enables the RAG service
      host_mount = os.getenv("HOME"),        -- Host mount path for files to be indexed (Docker will mount this path)
      runner = "docker",                     -- Runner for the RAG service (can use docker or nix)
      llm = {                                -- Language Model (LLM) configuration for RAG service
        provider = "ollama",                 -- Ollama provider
        endpoint = "http://localhost:11434", -- Ollama API endpoint (assuming local)
        api_key = nil,                       -- API key is typically not used for local Ollama
        model = "llama2:latest",             -- Example Ollama LLM model, change if you use another
        extra = nil,                         -- Additional configuration options for LLM
      },
      embed = {                              -- Embedding model configuration for RAG service
        provider = "ollama",                 -- Ollama provider for embeddings
        endpoint = "http://localhost:11434", -- Ollama API endpoint (assuming local)
        api_key = nil,                       -- API key is typically not used for local Ollama
        model = "nomic-embed-text",          -- Example Ollama embedding model, change if you use another
        extra = nil,                         -- Additional configuration options for the embedding model
      },
      -- *** IMPORTANT CHANGE FOR PERSISTENCE ***
      -- This maps a directory on your host to the internal data directory of the Docker container.
      -- The RAG service's index will be stored in this host directory.
      docker_extra_args = "--volume " .. os.getenv("HOME") .. "/.local/share/avante-rag-index:/app/data",
    },
  },

  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- Optional dependencies
    "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
    {
      -- Support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = false, -- Required for Windows users
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  -- This is where the RAG launch and resource adding code should go
  config = function(_, opts)
    -- Explicitly call setup with the opts table to ensure Avante's internal config is ready
    require("avante").setup(opts)

    -- IMPORTANT: Even when using Ollama, Avante's RAG service might still check
    -- for the OPENAI_API_KEY environment variable. If you encounter an error
    -- like "OPENAI_API_KEY is not set", you might need to set a dummy value
    -- in your shell environment before launching Neovim, e.g.:
    -- export OPENAI_API_KEY="dummy_key_for_avante_rag"

    local rag_service = require("avante.rag_service")
    local vimwiki_path = vim.fn.expand("~/vimwiki/") -- Ensure this is your correct Vimwiki path

    rag_service.launch_rag_service(function()
      print("Avante RAG service is running!")
      -- Add your Vimwiki directory for indexing once the service is ready
      rag_service.add_resource("file://" .. vimwiki_path)
      print("Vimwiki directory " .. vimwiki_path .. " sent for indexing.")
    end)
  end,
}
return M
