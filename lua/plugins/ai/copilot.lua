M = {
  "github/copilot.vim",
  config = function()
    local copilot = require("copilot")
    copilot.setup({
      suggestions = { enabled = false },
      panel = { enabled = false },
    })
  end,
}

return M
