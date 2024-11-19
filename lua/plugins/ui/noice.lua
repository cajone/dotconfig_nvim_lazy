
M = {
  "folke/noice.nvim",
  event = "VeryLazy", -- Load plugin lazily when needed
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify", -- Use nvim-notify for notifications
  },
  opts = {
    presets = {
      bottom_search = false, -- Use classic bottom cmdline for search
      command_palette = false, -- Position cmdline and popupmenu together (optional)
      long_message_to_split = true, -- Send long messages to a split
      inc_rename = true, -- Enable input dialog for inc-rename.nvim
      lsp_doc_border = true, -- Add border to hover docs and signature help
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- Requires hrsh7th/nvim-cmp
      },
      hover = { enabled = true, view = nil }, -- Use default view or custom one
      signature = { enabled = true, auto_open = false }, -- Auto open on cursor movement (optional)
    },
    views = {
      popupmenu = {
        border = true, -- Add border around the popup menu
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:NoicePopupmenuBorder,CursorLine:Normal", -- Customize window highlights
        },
      },
    },
    messages = { enabled = true, view_search = false }, -- Use dedicated search view (optional)
    statusmsg = { enabled = true, view = "mini" }, -- Status bar integration (optional)
    cmd_palette = {
      enabled = false, -- Enable command palette
      position = { row = 10, col = 4 },
      border = true, -- Add border around the command palette
      keymap = {
        next = "<C-j>", -- Next item in command palette
        prev = "<C-k>", -- Previous item in command palette
        confirm = "<CR>", -- Confirm selection in command palette
        cancel = "<Esc>", -- Cancel selection in command palette
      },
    },
    routes = {
      { filter = { event = "msg_show", find = "written" }, view = "mini" }, -- Route messages to mini view
      { filter = { event = "lsp_progress" }, view = "mini" }, -- Route LSP progress to mini view
    },
    notify = {
      enabled = true, -- Enable notifications
      timeout = 5000, -- Set notification timeout (ms)
      level = 2, -- Notifications level (1: error, 2: warn, 3: info, 4: debug)
    },
    dismiss = {
      enabled = true, -- Enable message dismissal based on events
      events = { "insert", "buf_enter" },
    },
  },
}

return M

