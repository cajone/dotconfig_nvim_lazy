M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter")

    -- New version setup
    configs.setup({
      ensure_installed = {
        "bash",
        "c",
        "groovy",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      -- 'auto_install' and 'highlight' are handled differently in the rewrite,
      -- but many setups still use this table for compatibility layers.
      highlight = { enable = true },
    })

    -- For Incremental Selection in the new branch:
    -- The rewrite actually deprecated the old internal module.
    -- Most users now use 'mini.ai' or 'nvim-treesitter-textobjects'.
  end,
}
return M
