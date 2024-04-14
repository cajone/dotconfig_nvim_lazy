M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  dependencies = {
     "hrsh7th/cmp-buffer",            -- source for text in buffer
     "hrsh7th/cmp-path",              -- source for file system path
     "L3MON4D3/LuaSnip",              -- Snippet Engine
     "saadparwaiz1/cmp_luasnip",      -- for autocompletion
     "rafamadriz/friendly-snippets",  -- useful snippets
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins ( e.g. friendly-snippets )
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
         completeopt = "menu,menuone,preview,noselect",
      },                                                      -- :h completeopt for details

      snippet = {                                             -- config how nvim-cmp interacts with snippet engine
         expand = function(args)
           luasnip.lsp_expand(args.body)
         end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm { select = false },
      }),

      sources = cmp.config.sources({            -- ORDER MATTERS HERE
        { name = "nvim_lsp" },
        { name = "luasnip" },   -- snippets
        { name = "buffer" },    -- text within curent buffer
        { name = "path" },      -- file system paths
      }),
    })
  end,
} return M
