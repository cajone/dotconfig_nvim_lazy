M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --  build = "cd app && yarn install",
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  --  init = function()
  --    vim.g.mkdp_filetypes = { "markdown" }
  --  end,
}
return M
