M = {
  { "nvim-tree/nvim-web-devicons" }, -- Icons for files
  {
    "nvim-tree/nvim-tree.lua",
    icons = require("icons"),
    config = function()
      local dressing = require("dressing")
      dressing.setup()

      require("nvim-tree").setup({
        auto_reload_on_write = false,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        sort_by = "name",
        root_dirs = {},
        sync_root_with_cwd = true,
        on_attach = "default",
        view = {
          width = 30,
          side = "left",
          number = false,
          relativenumber = false,
          signcolumn = "yes",
          float = {
            enable = false,
            open_win_config = {
              relative = "editor",
              border = "rounded",
              width = 30,
              height = 30,
              row = 1,
              col = 1,
            },
          },
        },
        renderer = {
          highlight_git = true,
          indent_width = 2,
          special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        },
        hijack_directories = {
          enable = false,
          auto_open = true,
        },
        update_focused_file = {
          enable = true,
          debounce_delay = 15,
          update_root = true,
        },
        diagnostics = {
          enable = false,
          show_on_dirs = false,
          show_on_open_dirs = true,
          debounce_delay = 50,
        },
        filters = {
          dotfiles = false,
          git_clean = false,
          custom = { "node_modules", "\\.cache" },
        },
        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 200,
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
          },
          open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
              enable = true,
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },
        trash = {
          cmd = "trash",
          require_confirm = true,
        },
        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = true,
        },
      })
    end,
  },
}
return M

