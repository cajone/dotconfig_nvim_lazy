return {
    'ldelossa/gh.nvim',
  dependencies = {
    'ldelossa/litee.nvim',
--    'folke/which-key.nvim',
  },
    config = function()
      require("litee.lib").setup()
      require("litee.gh").setup()
    end,
 }
