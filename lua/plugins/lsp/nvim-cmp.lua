M = {
  { -- Language Server Protocol
    "hrsh7th/cmp-nvim-lsp",
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "kmarius/jsregexp",             -- still an issue with this showing in :checkhealth
      "saadparwaiz1/cmp_luasnip",     -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
    },
  },

  {
    "hrsh7th/nvim-cmp",     -- Code completion
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path",   -- source for file system path
    },

    event = "InsertEnter",

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- loads vscode style snippets from installed plugins ( e.g. friendly-snippets )
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({

        snippet = { -- config how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
          extensions = { "jenkinsfile", "groovy" }, -- files that have a suffix of jenkinsfile are actually groovy
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        completion = { -- :h completeopt for details
          completeopt = "menu,menuone,preview,noselect",
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(-4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({ -- ORDER MATTERS HERE
          { name = "nvim_lsp" },       -- lsp
          { name = "luasnip" },        -- snippets
          { name = "buffer" },         -- text within curent buffer
          { name = "path" },           -- file system paths
        }),
      })
    end,
  },
}
return M
