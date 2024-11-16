M = {
  "folke/noice.nvim",
  event = "VeryLazy", -- Load the plugin lazily when needed
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- If you want to use nvim-notify for notifications, uncomment the following line:
    -- "rcarriga/nvim-notify",
  },
  opts = {
    -- Enable or disable various features
    presets = {
      bottom_search = false, -- Use a classic bottom cmdline for search
      command_palette = false, -- Position the cmdline and popupmenu together (optional)
      long_message_to_split = true, -- Long messages will be sent to a split
      inc_rename = true, -- Enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- Add a border to hover docs and signature help
    },

    -- Configure LSP-specific settings
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- Requires hrsh7th/nvim-cmp
      },
      hover = {
        enabled = true,
        view = nil, -- Use the default view or specify a custom one
      },
      signature = {
        enabled = true,
        auto_open = false, -- Automatically open signature help on cursor movement
      },
    },

    -- Configure views for different types of messages
    views = {
      popupmenu = { -- Configure the popup menu
        border = true, -- Add a border around the popup menu
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:NoicePopupmenuBorder,CursorLine:Normal", -- Customize window highlights
        },
      },
    },

    -- Notification settings
    messages = {
      enabled = true,
      view_search = false, -- Use a dedicated search view for notifications (optional)
    },

    -- Status bar integration (optional)
    statusmsg = {
      enabled = true,
      view = "mini",
    },

    -- Command palette settings (if enabled)
    cmd_palette = {
      enabled = false, -- Enable the command palette
      position = {
        row = 10, -- Position of the command palette
        col = 4,
      },
      border = true, -- Add a border around the command palette
      keymap = {
        next = "<C-j>", -- Key mappings for navigation in the command palette
        prev = "<C-k>",
        confirm = "<CR>",
        cancel = "<Esc>",
      },
    },

    -- Customization of specific message types (optional)
    routes = {
      { filter = { event = "msg_show", find = "written" }, view = "mini" }, -- Route messages with "written" to the mini view
      { filter = { event = "lsp_progress" }, view = "mini" }, -- Route LSP progress messages to the mini view
    },

    -- Customization of notifications (optional)
    notify = {
      enabled = true, -- Enable notifications
      timeout = 5000, -- Set notification timeout in milliseconds
      level = 2, -- Notification level (1: error, 2: warn, 3: info, 4: debug)
    },

    -- Miscellaneous settings
    dismiss = {
      enabled = true, -- Enable dismissing messages
      events = { "insert", "buf_enter" }, -- Events that trigger message dismissal
    },
  },
}

return M
