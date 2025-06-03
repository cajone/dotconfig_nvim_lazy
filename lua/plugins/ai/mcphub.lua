-- In your plugins/mcphub.lua or similar setup file
return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  -- The 'build' command ensures mcp-hub is installed when the plugin is installed/updated
  build = "npm install -g mcp-hub@latest",
  -- Or, if you want to use a bundled binary with the plugin (requires `use_bundled_binary = true` in setup)
  -- build = "bundled_build.lua",
  config = function()
    require("mcphub").setup({
      -- You can specify a port if needed, default is 3000
      port = 3010,
      -- This is the path to the configuration file for the mcp-hub backend.
      -- mcphub.nvim will manage this file.
      config = vim.fn.expand("~/.config/mcphub/servers.json"),
      -- If you used build = "bundled_build.lua" above, uncomment this:
      -- use_bundled_binary = true,
      on_ready = function(hub)
        vim.notify(string.format("MCP Hub is ready on port %s", hub.port))
      end,
    })
  end,
}

--M = {
--  "ravitemer/mcphub.nvim",
--  dependencies = {
--    "nvim-lua/plenary.nvim",
--  },
--  build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
--  config = function()
--    require("mcphub").setup({
--      --- `mcp-hub` binary related options-------------------
--      config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
--      port = 3010,                                             -- The port `mcp-hub` server listens to
--      shutdown_delay = 60 * 10 * 000,                          -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)
--      use_bundled_binary = false,                              -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
--      mcp_request_timeout = 60000,                             --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks
--
--      ---Chat-plugin related options-----------------
--      auto_approve = false,           -- Auto approve mcp tool calls
--      auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
--      extensions = {
--        avante = {
--          make_slash_commands = true, -- make /slash commands from MCP server prompts
--        }
--      },
--
--      --- Plugin specific options-------------------
--      native_servers = {}, -- add your custom lua native servers here
--      ui = {
--        window = {
--          width = 0.8,      -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
--          height = 0.8,     -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
--          align = "center", -- "center", "top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right"
--          relative = "editor",
--          zindex = 50,
--          border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
--        },
--        wo = {                -- window-scoped options (vim.wo)
--          winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
--        },
--      },
--      on_ready = function(hub)
--        -- Called when hub is ready
--      end,
--      on_error = function(err)
--        -- Called on errors
--      end,
--      log = {
--        level = vim.log.levels.WARN,
--        to_file = false,
--        file_path = nil,
--        prefix = "MCPHub",
--      },
--    })
--  end
--}
--return M
