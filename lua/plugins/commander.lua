-- Plugin Manager: lazy.nvim
return {
  { "jonarrien/telescope-cmdline.nvim" },
  dependencies = {
      "nvim-telescope/telescope.nvim",
  },
  require("telescope").setup({
    extensions = {
      cmdline = {
        picker = {
          layout_config = {
            width  = 120,
            height = 25,
          }
        },
        mappings    = {
          complete      = '<Tab>',
          run_selection = '<C-CR>',
          run_input     = '<CR>',
        },
      },
    }
  }),
--  vim.api.nvim_set_keymap('n', ':', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" }),
--  vim.api.nvim_set_keymap('n', '<leader><leader>', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })
}
