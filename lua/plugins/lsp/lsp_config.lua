M = {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- Ctrl-x Ctrl-o
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						-- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			require("lspconfig").lua_ls.setup({
        diagnostics = { disable = { "missing-fields", "undefined-global" } },
      })
		end
	}
}
return M





-- M = {
--   {
--     "neovim/nvim-lspconfig",
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",
--       { "antosha417/nvim-lsp-file-operations", config = true },
--       { "williamboman/mason.nvim",             config = true }, -- NOTE: Must be loaded before dependants
--       { "hrsh7th/cmp-nvim-lsp" },
--       {
--         "antosha417/nvim-lsp-file-operations",
--         dependencies = {
--           "nvim-lua/plenary.nvim",
--         },
--         config = true,
--       },
--       { "WhoIsSethDaniel/mason-tool-installer.nvim" },
--       { "j-hui/fidget.nvim",                        opts = {} },
--       { "folke/neodev.nvim",                        opts = {} },
--       { "VonHeikemen/lsp-zero.nvim",                opts = {} },
--     },
--
--     config = function()
--       local builtin = require("telescope.builtin")
--       vim.api.nvim_create_autocmd("LspAttach", {
--         group = vim.api.nvim_create_augroup("plugins-lsp-lsp-attach", { clear = true }),
--         callback = function(event)
--           local map = function(keys, func, desc)
--             vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
--           end
--
--           -- Got the definition of the function
--           map("gd", builtin.lsp_definitions, "[g]oto [d]efinition")
--
--           -- Find references for the word under your cursor.
--           map("gr", builtin.lsp_references, "[g]oto [r]eferences")
--
--           -- Jump to the implementation of the word under your cursor.
--           --  Useful when your language has ways of declaring types without an actual implementation.
--           map("gI", builtin.lsp_implementations, "[g]oto [I]mplementation")
--
--           -- Jump to the type of the word under your cursor.
--           --  Useful when you're not sure what type a variable is and you want to see
--           --  the definition of its *type*, not where it was *defined*.
--           map("<leader>ld", builtin.lsp_type_definitions, "Type [D]efinition")
--
--           -- Fuzzy find all the symbols in your current document.
--           --  Symbols are things like variables, functions, types, etc.
--           map("<leader>ds", builtin.lsp_document_symbols, "[d]ocument [s]ymbols")
--
--           -- Fuzzy find all the symbols in your current workspace.
--           --  Similar to document symbols, except searches over your entire project.
--           map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
--
--           -- Rename the variable under your cursor.
--           --  Most Language Servers support renaming across files, etc.
--           map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
--
--           -- Execute a code action, usually your cursor needs to be on top of an error
--           -- or a suggestion from your LSP for this to activate.
--           map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
--
--           -- Opens a popup that displays documentation about the word under your cursor
--           --  See `:help K` for why this keymap.
--           map("K", vim.lsp.buf.hover, "Hover Documentation")
--
--           -- WARN: This is not Goto Definition, this is Goto Declaration.
--           --  For example, in C this would take you to the header.
--           map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
--
--           -- The following two autocommands are used to highlight references of the
--           -- word under your cursor when your cursor rests there for a little while.
--           --    See `:help CursorHold` for information about when this is executed
--           --
--           -- When you move your cursor, the highlights will be cleared (the second autocommand).
--           local client = vim.lsp.get_client_by_id(event.data.client_id)
--           if client and client.server_capabilities.documentHighlightProvider then
--             local highlight_augroup = vim.api.nvim_create_augroup("plugins-lsp-lsp-highlight", { clear = false })
--             vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--               buffer = event.buf,
--               group = highlight_augroup,
--               callback = vim.lsp.buf.document_highlight,
--             })
--
--             vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--               buffer = event.buf,
--               group = highlight_augroup,
--               callback = vim.lsp.buf.clear_references,
--             })
--           end
--
--           -- The following autocommand is used to enable inlay hints in your
--           -- code, if the language server you are using supports them
--           --
--           -- This may be unwanted, since they displace some of your code
--           if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
--             map("<leader>th", function()
--               vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
--             end, "[T]oggle Inlay [H]ints")
--           end
--         end,
--       })
--
--       vim.api.nvim_create_autocmd("LspDetach", {
--         group = vim.api.nvim_create_augroup("plugins-lsp-lsp-detach", { clear = true }),
--         callback = function(event)
--           vim.lsp.buf.clear_references()
--           vim.api.nvim_clear_autocmds({ group = "plugins-lsp-lsp-highlight", buffer = event.buf })
--         end,
--       })
--
--       -- LSP servers and clients are able to communicate to each other what features they support.
--       --  By default, Neovim doesn't support everything that is in the LSP specification.
--       --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--       --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
--       local capabilities = vim.lsp.protocol.make_client_capabilities()
--       capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
--
--       local servers = {
--         lua_ls = {
--           -- cmd = {...},
--           -- filetypes = { ...},
--           -- capabilities = {},
--           settings = {
--             Lua = {
--               completion = {
--                 callSnippet = "Replace",
--               },
--               -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--               diagnostics = { disable = { "missing-fields", "undefined-global" } },
--             },
--           },
--         },
--         ansiblels = {
--           settings = {
--             Ansible = {
--               completion = {
--                 callSnippet = "Replace",
--               },
--               diagnostics = { disable = { "missing-fields", "undefined-global" } },
--             },
--           },
--         },
--       }
--
--
--
--       require 'lspconfig'.lua_ls.setup {
--         on_init = function(client)
--           if client.workspace_folders then
--             local path = client.workspace_folders[1].name
--             if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
--               return
--             end
--           end
--
--           client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
--             runtime = {
--               -- Tell the language server which version of Lua you're using
--               -- (most likely LuaJIT in the case of Neovim)
--               version = 'LuaJIT'
--             },
--             -- Make the server aware of Neovim runtime files
--             workspace = {
--               checkThirdParty = false,
--               library = {
--                 vim.env.VIMRUNTIME
--                 -- Depending on the usage, you might want to add additional paths here.
--                 -- "${3rd}/luv/library"
--                 -- "${3rd}/busted/library",
--               }
--               -- or pull in all of 'runtimepath'.
--               -- NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
--               -- library = vim.api.nvim_get_runtime_file("", true)
--             }
--           })
--         end,
--         settings = {
--           Lua = {}
--         }
--       }
--
--
--
--       require("lspconfig").groovyls.setup({
--         on_attach = on_attach,
--         filetypes = { "groovy" },
--         settings = {
--           groovy = {
--             classpath = {
--               "/home/thomsope/.local/share/nvim/mason/packages/groovy-language-server/build/libs/",
--             },
--           },
--         },
--         cmd = {
--           "java",
--           "-jar",
--           "/home/thomsope/.local/share/nvim/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar",
--         },
--       })
--
--       -- require("npm-groovy-lint").setup()
--       require("mason").setup()
--
--       -- You can add other tools here that you want Mason to install
--       -- for you, so that they are available from within Neovim.
--       local ensure_installed = vim.tbl_keys(servers or {})
--       vim.list_extend(ensure_installed, {
--         "stylua", -- Used to format Lua code
--       })
--       require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
--
--       require("mason-lspconfig").setup({
--         handlers = {
--           function(server_name)
--             local server = servers[server_name] or {}
--             -- This handles overriding only values explicitly passed
--             -- by the server configuration above. Useful when disabling
--             -- certain features of an LSP (for example, turning off formatting for tsserver)
--             server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
--             require("lspconfig")[server_name].setup(server)
--           end,
--         },
--       })
--     end,
--   },
--
--   { -- Autocompletion
--     "hrsh7th/nvim-cmp",
--     event = "InsertEnter",
--     dependencies = {
--       -- Snippet Engine & its associated nvim-cmp source
--       {
--         "L3MON4D3/LuaSnip",
--         build = (function()
--           -- Build Step is needed for regex support in snippets.
--           -- This step is not supported in many windows environments.
--           -- Remove the below condition to re-enable on windows.
--           if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
--             return
--           end
--           return "make install_jsregexp"
--         end)(),
--         dependencies = {
--           -- `friendly-snippets` contains a variety of premade snippets.
--           --    See the README about individual language/framework/plugin snippets:
--           --    https://github.com/rafamadriz/friendly-snippets
--           -- {
--           --   'rafamadriz/friendly-snippets',
--           --   config = function()
--           --     require('luasnip.loaders.from_vscode').lazy_load()
--           --   end,
--           -- },
--         },
--       },
--       "saadparwaiz1/cmp_luasnip",
--
--       -- Adds other completion capabilities.
--       --  nvim-cmp does not ship with all sources by default. They are split
--       --  into multiple repos for maintenance purposes.
--       "hrsh7th/cmp-nvim-lsp",
--       "hrsh7th/cmp-path",
--     },
--
--     --- Completion & Snippets
--     config = function()
--       -- See `:help cmp`
--       local cmp = require("cmp")
--       local luasnip = require("luasnip")
--       luasnip.config.setup({})
--
--       -- cmp = completion
--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end,
--         },
--         completion = { completeopt = "menu,menuone,noinsert" },
--
--         -- For an understanding of why these mappings were
--         -- chosen, you will need to read `:help ins-completion`
--         --
--         -- No, but seriously. Please read `:help ins-completion`, it is really good!
--         mapping = cmp.mapping.preset.insert({
--           -- Select the [n]ext item
--           ["<C-n>"] = cmp.mapping.select_next_item(),
--           -- Select the [p]revious item
--           ["<C-p>"] = cmp.mapping.select_prev_item(),
--
--           -- Scroll the documentation window [b]ack / [f]orward
--           ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--           ["<C-f>"] = cmp.mapping.scroll_docs(4),
--
--           -- Accept ([y]es) the completion.
--           --  This will auto-import if your LSP supports it.
--           --  This will expand snippets if the LSP sent a snippet.
--           ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--
--           -- If you prefer more traditional completion keymaps,
--           -- you can uncomment the following lines
--           --['<CR>'] = cmp.mapping.confirm { select = true },
--           --['<Tab>'] = cmp.mapping.select_next_item(),
--           --['<S-Tab>'] = cmp.mapping.select_prev_item(),
--
--           -- Manually trigger a completion from nvim-cmp.
--           --  Generally you don't need this, because nvim-cmp will display
--           --  completions whenever it has completion options available.
--           ["<C-Space>"] = cmp.mapping.complete({}),
--
--           -- Think of <c-l> as moving to the right of your snippet expansion.
--           --  So if you have a snippet that's like:
--           --  function $name($args)
--           --    $body
--           --  end
--           --
--           -- <c-l> will move you to the right of each of the expansion locations.
--           -- <c-h> is similar, except moving you backwards.
--           ["<C-l>"] = cmp.mapping(function()
--             if luasnip.expand_or_locally_jumpable() then
--               luasnip.expand_or_jump()
--             end
--           end, { "i", "s" }),
--           ["<C-h>"] = cmp.mapping(function()
--             if luasnip.locally_jumpable(-1) then
--               luasnip.jump(-1)
--             end
--           end, { "i", "s" }),
--
--           -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--           --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
--         }),
--         sources = {
--           { name = "nvim_lsp" },
--           { name = "luasnip" },
--           { name = "path" },
--         },
--       })
--     end,
--   },
-- }
-- return M
