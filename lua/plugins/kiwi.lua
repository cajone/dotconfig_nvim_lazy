M = {
  "serenevoid/kiwi.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim", -- ADDED/MOVED HERE: Ensure render-markdown is a top-level plugin
  },
  opts = {
    {
      name = "wiki",
      path = "/home/pete/vimwiki",
    },
  },
  keys = {
    { "<leader>wp", ':lua require("kiwi").open_wiki_index("personal")<cr>', desc = "Open index of personal wiki" },
    { "T",          ':lua require("kiwi").todo.toggle()<cr>',               desc = "Toggle Markdown Task" },
  },
  lazy = true,
}
return M
