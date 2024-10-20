M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<c-\>]],
    size = 20,
    direction = "float",
    hide_numbers = true,
    shading_factor = 4,
    shade_filetypes = {},
    start_in_insert = true,
    insert_mapping = true,
    persistent_size = true,
    close_on_exit = true,
    shell = vim.o.shell,
    hightlights = {
      Normal = {
        guibg = "#000000",
      },
    },
  },
}
return M
