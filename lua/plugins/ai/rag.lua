M = {
  -- After launching the RAG service, or in a subsequent Neovim session:
  local rag_service = require("avante.rag_service")

  local vimwiki_path = vim.fn.expand("~/.vimwiki/") -- Ensure trailing slash for directory
  rag_service.add_resource("file://" .. vimwiki_path)

  print("Vimwiki directory " .. vimwiki_path .. " sent for indexing.")
}
return M
