local M = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  opts = {
    provider = "qwen3:32b", -- Your desired default Ollama model for primary use

    providers = {
      -- 1. Base 'ollama' provider: Essential for Avante's first-class Ollama integration.
      ollama = {
        endpoint = "http://localhost:11434",
        model = "qwen3:32b",   -- A generic default model for the base 'ollama' provider
        extra_request_body = { -- Ensure this block is present
          options = {
            temperature = 0.0, -- Set temperature to 0.0 for minimal hallucination
            num_ctx = 20480,
            keep_alive = "5m",
          },
        },
      },

      -- 2. Base 'openai' provider: Crucial for your specific Ollama models to inherit from.
      openai = {
        endpoint = "http://localhost:11434/v1", -- Point to Ollama's OpenAI-compatible endpoint
        model = "llama3",                       -- A dummy model for the base 'openai' definition, not meant for direct selection
        extra_request_body = {                  -- Ensure this block is present
          temperature = 0.0,                    -- Set temperature to 0.0 for minimal hallucination
        },
      },

      -- 3. Specific Ollama models as top-level providers: These are the ones you want to select.
      ["llama4:latest"] = {
        __inherited_from = "openai",
        endpoint = "http://localhost:11434/v1",
        model = "llama4:latest",
        display_name = "Ollama - Llama4:latest",
        extra_request_body = {
          options = {
            temperature = 0.0,
          },
        },
      },
      -- All other default providers are *implicitly excluded* because they are not listed here.
    },
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
      -- *** START: Re-added debug_introspection shortcut ***
      debug_introspection = {
        question = "@codebase\n" ..
            "I am encountering a runtime bug in my project. I have a shell script named `introspection.sh` in the project root that is designed to help diagnose issues, and it is expected to throw an error when the bug is present.\n\n" ..
            "Here is the plan:\n" ..
            "1.  **Run the `introspection.sh` script.** You can do this by executing a shell command.\n" ..
            "2.  **Analyze the output, particularly any error messages or stack traces.**\n" ..
            "3.  **Based on the error, identify potential root causes within the codebase.**\n" ..
            "4.  **If the root cause is not immediately clear, suggest a modification to `introspection.sh` or a specific file to inspect, then re-run `introspection.sh` to gather more information.**\n" ..
            "5.  **Repeat steps 2-4** until you have a clear picture of the root cause and can propose a concrete solution.\n\n" ..
            "My goal is for you to identify the root cause of the bug and propose a fix.",
        description = "Debugs a runtime bug using iterative introspection.sh runs.",
      },
      -- *** END: Re-added debug_introspection shortcut ***
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
