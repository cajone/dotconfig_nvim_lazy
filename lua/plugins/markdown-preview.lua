M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  ft = { "markdown" },
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,

  markdown_css = "", -- set a custom CSS style for rendering markdown files
  highlight_css = "", -- set a custom CSS style for syntax highlighting
  port = "", -- specify a custom port for starting the server or leave empty for random port
  page_title = "「%{name}」", -- preview page title, replace {name} with file name
  images_path = "/home/user/.markdown_images", -- set a custom location for markdown images

  filetypes = {"markdown"}, -- list of recognized filetypes for MarkdownPreview commands
  theme = "dark", -- set default theme (dark or light)
  combine_preview = false, -- enable reusing previously opened preview windows
  combine_preview_auto_refresh = true, -- auto-refetch combine preview contents when markdown buffer changes

  mkdp = {
    auto_start = false, -- set to 1 for automatic preview window opening
    auto_close = true, -- set to 1 for auto-closing current preview window on buffer change
    refresh_slow = false, -- enable/disable slow refresh of markdown files
    command_for_global = false, -- allow MarkdownPreview for all files (default: markdown files only)
    open_to_the_world = false, -- make the preview server accessible to others on your network
    open_ip = "", -- specify a custom IP for opening the preview page
    browser = "", -- set a custom browser for opening preview pages
    echo_preview_url = false, -- show the URL in command line when opening preview page
    browserfunc = "", -- define a custom function name to open preview pages with URL as argument
  },

  mkdp_preview_options = {
    mkit = {}, -- Markdown rendering options
    katex = {}, -- KaTeX options for math
    uml = {}, -- markdown-it-plantuml options
    maid = {}, -- mermaid options
    disable_sync_scroll = false, -- disable sync scroll
    sync_scroll_type = "middle", -- set synchronization type (middle, top, relative)
    hide_yaml_meta = true, -- hide YAML metadata in preview page
    sequence_diagrams = {}, -- js-sequence-diagrams options
    flowchart_diagrams = {}, -- mermaid flowchart diagrams options
    content_editable = false, -- enable content editable for preview page
    disable_filename = false, -- disable filename header for preview page
    toc = {} -- Markdown table of contents options
  }
} return M
