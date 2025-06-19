-- /home/pete/.config/pvim/lua/plugins/ai/llm.lua

-- IMPORTANT: This is a direct workaround for a persistent module loading issue.
-- It ensures 'model' can be found by manually adding its path to Lua's package.path.
local llm_plugin_root = vim.fn.stdpath("data") .. "/lazy/llm.nvim" -- This path is correct due to GitHub redirect
-- Add the 'lua' subdirectory of the plugin to package.path
package.path = package.path .. ";" .. llm_plugin_root .. "/lua/?.lua"
package.path = package.path .. ";" .. llm_plugin_root .. "/lua/?/init.lua"


return {
  "gsuuon/llm.nvim", -- Keep this as "gsuuon/llm.nvim", it redirects correctly.
  lazy = false,
  config = function()
    print("DEBUG: Inside llm.nvim config function, attempting require('model')") -- Changed debug print
    -- >>>>>> THIS IS THE FINAL CHANGE <<<<<<
    require("model").setup({                                                     -- Change 'llm_nvim' to 'model'
      backend = "openai",
      openai = {
        api_key = "my-custom-litellm-key",
        api_base = "http://localhost:9001/v1",
        model = "codegemma-local",
      },
      models = {
        default = "codegemma-local",
        chat = "llama3-local",
        code = "codegemma-local",
      },
      prompts = {
        default = "You are a helpful programming assistant.",
        code_gen = "Generate %s code for the following: ",
        explain = "Explain the following code: ",
        refactor = "Refactor the following code: ",
      },
      mappings = {
        generate_code = "<leader>lg",
        explain_code = "<leader>le",
        refactor_code = "<leader>lr",
        chat = "<leader>lc",
      },
    })
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
