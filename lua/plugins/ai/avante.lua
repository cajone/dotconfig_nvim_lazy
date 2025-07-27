local M = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  opts = {
    provider = "qwen3:14b", -- Your desired default Ollama model for primary use

    -- *** START: CONSTRUCTING THE 'providers' TABLE BEFORE SETUP ***
    -- This table will be passed directly to avante.setup(opts)
    -- It will ONLY contain the providers you want to be active.
    providers = {
      -- 1. Simple, BASE Ollama provider (for general Ollama connection)
      ollama = {
        endpoint = "http://localhost:11434",
        model = "qwen3:14b", -- A generic default model for the base 'ollama' provider
      },

      -- 2. Simple, BASE OpenAI provider (required for inheriting, points to Ollama's OpenAI-compatible API)
      openai = {
        endpoint = "http://localhost:11434/v1", -- *** Point to Ollama's OpenAI-compatible endpoint ***
        model = "llama3",                       -- A dummy model for the base 'openai' definition, not meant for direct selection
      },

      -- 3. Specific Ollama models as top-level providers (inheriting from 'openai')
      -- These are the models that will appear in your :AvanteModels popup.
      ["qwen3:14b"] = {
        __inherited_from = "openai",            -- Inherit parsing from the 'openai' provider (which points to Ollama)
        endpoint = "http://localhost:11434/v1", -- Explicitly point to Ollama's OpenAI-compatible endpoint
        model = "qwen3:14b",
        display_name = "Ollama - Qwen3 14B",
      },
      ["qwen3:8b"] = {
        __inherited_from = "openai",
        endpoint = "http://localhost:11434/v1",
        model = "qwen3:8b",
        display_name = "Ollama - Deepseek Coder V2 16B",
      },
      ["deepseek-r1:8b"] = {
        __inherited_from = "openai",
        endpoint = "http://localhost:11434/v1",
        model = "deepseek-r1:8b",
        display_name = "Ollama - Deepseek R1 8B",
      },
      -- All other unwanted default providers are *implicitly excluded* because they are not listed here.
    },
    -- *** END: CONSTRUCTING THE 'providers' TABLE BEFORE SETUP ***

    shortcuts = {
      project_cleanup = {
        question = "@codebase\n" ..
            "Please provide a concise summary of this project, including its primary purpose, main components, and overall architecture.\n\n" ..
            "Additionally, based on the project's purpose and typical project structures, identify any files or directories that appear to be irrelevant, temporary, or not directly contributing to the core functionality. Suggest which ones could potentially be safely removed, along with a brief reason for each suggestion. Focus on common development artifacts, unused documentation, or unexpected files.",
        description = "Summarizes the project and suggests irrelevant files for cleanup.",
      },
      explain_file = {
        question = "@file\n" ..
            "Please explain the purpose of this file, its main functions and how it fits into the overall project. Focus on providing a high-level overview.",
        description = "Explains the purpose and functionality of the current file.",
      },
      refactor_selection = {
        question =
        "Refactor the following code to improve readability, efficiency and adherence to best practices. Provide the refactored code and a brief explanation of the changes:\n\n{{selection}}",
        description = "Refactors selected code for readability and efficiency.",
      },
      generate_test = {
        question = "@file\n" ..
            "Generate a unit test case for the function/code provided. Use the standard testing framework for this language (e.g., `pytest` for Python, `jest` for JavaScript). Focus on a single, representative test case demonstrating core functionality:\n\n{{selection}}",
        description = "Generates a unit test case for the selected code.",
      },
      add_docs = {
        question =
        "Add a comprehensive docstring/comments to the following code. Use standard conventions for this language (e.g., JSDoc for JavaScript, Sphinx/NumPy style for Python). Focus on parameters, return values, and a brief description of what the code does:\n\n{{selection}}",
        description = "Adds docstrings/comments to the selected code.",
      },
      explain_error = {
        question =
        "I encountered the following error. Please explain what it means and suggest possible causes and solutions, considering the surrounding code if provided:\n\n{{selection}}",
        description = "Explains an error and suggests solutions.",
      },
    },
    layout = {
      position = "right",
      width = 50,                -- Set to 50 for 50% of the available window width
      panel_ratio = { 5, 3, 1 }, -- This controls the internal vertical splits of the Avante panel
    },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    require("avante").setup(opts)

    -- The post-setup filtering loop is now removed, as the providers are pre-filtered.
    -- (Lines 93-108 from previous version are removed).

    -- Custom command: AvanteListShortcuts (remains the same)
    vim.api.nvim_create_user_command(
      "AvanteListShortcuts",
      function()
        local shortcuts = opts and opts.shortcuts
        if not shortcuts or vim.tbl_isempty(shortcuts) then
          print("No Avante.nvim shortcuts defined in the configuration.")
          print("Note: This command lists shortcuts from your main Avante.nvim config.")
          return
        end
        print("--- Avante.nvim Shortcuts ---")
        local shortcut_names = vim.tbl_keys(shortcuts)
        table.sort(shortcut_names)
        for _, name in ipairs(shortcut_names) do
          local shortcut_info = shortcuts[name]
          local description = shortcut_info.description or "(No description)"
          print(string.format("#%s: %s", name, description))
        end
        print("----------------------------")
      end,
      {
        desc = "List all defined Avante.nvim shortcuts",
        bang = false,
        nargs = 0,
      }
    )

    vim.api.nvim_create_autocmd("WinEnter", {
      group = vim.api.nvim_create_augroup("AvanteForceResize", { clear = true }),
      pattern = "Avante",
      callback = function()
        local winid = vim.api.nvim_get_current_win()
        local total_cols = vim.opt.columns:get()
        local target_width = math.floor(total_cols * 0.5)

        local current_width = vim.api.nvim_win_get_width(winid)
        if current_width ~= target_width then
          vim.cmd(string.format("%dvertical resize %d", winid, target_width))
        end
      end,
      once = false,
      nested = true,
    })
  end,
}

return M
