M = {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "groovy",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "vim",
        "vimdoc",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "tis",
          node_incremental = "tni",
          scope_incremental = "tsi",
          node_decremental = "tnd",
        },
      },
    })
  end,
}
return M
