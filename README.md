# Pete's Neovim Config (lazy.nvim)

A fully featured Neovim configuration for Arch Linux, managed with **lazy.nvim**. Includes LSP tooling, autocompletion, git integration, telescope fuzzy finding, markdown/wiki support, debugging, and AI assistant.

## Requirements (Arch Linux)

```bash
sudo pacman -S --needed neovim git ripgrep fd xsel python python-pynvim \
  nodejs npm lua-language-server stylua shellcheck prettier
```

Optionally install `tree-sitter-cli` (for TS parser compilation) and a Nerd Font:
```bash
sudo pacman -S tree-sitter-cli ttf-nerd-fonts-symbols
```

## Installation

```bash
git clone https://github.com/cajone/dotconfig_nvim_lazy.git ~/.config/nvim
```

Set `NVIM_APPNAME` in your shell rc (e.g. `~/.zshrc`):
```bash
export NVIM_APPNAME="nvim"
```

Start Neovim — lazy.nvim will bootstrap itself and install all plugins:
```bash
nvim
```

### Post-Install

Install LSP servers and tools via Mason (run `:Mason` and check the installed list):
```bash
# Or let Mason auto-install on first LSP attach. Required servers:
# ansible-language-server, bash-language-server, groovy-language-server,
# lua-language-server, pyright, ruff, html-lsp
#
# Required formatters: prettier, stylua, beautysh, shellcheck
```

Run health check to verify:
```
:checkhealth
```

## Structure

```
~/.config/nvim
├── init.lua              # Entry point — sets leader key, loads lua/init
├── ftplugin/             # Filetype-specific settings
│   └── markdown.lua      # Markdown buffer options (conceal, spell, indent)
├── lua/
│   ├── init.lua          # Requires all plugin/config modules
│   ├── custom/           # Personal settings and keymaps
│   │   ├── opts.lua      # Editor options (tabs, numbers, clipboard, etc.)
│   │   ├── keys.lua      # Leader keybindings, telescope, window nav
│   │   ├── cmds.lua      # Autocommands, colorscheme, filetype detection
│   │   ├── local_fun.lua # Utility functions (toggle numbers, terminal, etc.)
│   │   ├── local_git_fun.lua  # Git helper functions
│   │   └── plugin_keys/  # Plugin-specific key mappings
│   │       ├── folding.lua
│   │       └── gp_path.lua
│   ├── plugins/          # Plugin specs for lazy.nvim
│   │   ├── init.lua      # Vimwiki setup, treesitter markdown registration
│   │   ├── lazy_load.lua # lazy.nvim bootstrap + plugin imports
│   │   ├── treesitter.lua
│   │   ├── git.lua       # Fugitive, Agit, Diffview, Gitsigns
│   │   ├── terminal.lua  # toggleterm.nvim
│   │   ├── neowiki.lua   # Neowiki markdown wiki
│   │   ├── obsidian.lua  # Obsidian vault integration
│   │   ├── render-markdown.lua
│   │   ├── markdown-preview.lua
│   │   ├── gh.lua        # GitHub CLI integration
│   │   ├── ai_companion.lua  # CodeCompanion + mcphub
│   │   ├── auto-sessions.lua # auto-session
│   │   ├── lsp/
│   │   │   ├── mason.lua      # Mason, mason-lspconfig, mason-tool-installer
│   │   │   ├── lsp_config.lua # LSP config (lua_ls)
│   │   │   ├── nvim-cmp.lua   # Autocompletion (cmp, luasnip)
│   │   │   ├── none-ls.lua    # null-ls replacement
│   │   │   └── debug.lua      # DAP, DAP UI
│   │   └── ui/
│   │       ├── colorscheme.lua # tokyonight
│   │       ├── lualine.lua     # Statusline
│   │       ├── telescope.lua   # Fuzzy finder
│   │       ├── dressing.lua    # Better UI prompts
│   │       ├── noice.lua       # UI notifications/command line
│   │       ├── conform.lua     # Formatter
│   │       ├── todo.lua        # todo-comments + mini
│   │       ├── mini.lua        # mini.nvim suite
│   │       └── fzf-lua.lua     # Alternative fuzzy finder
│   └── icons.lua
├── .markdownlint.yaml   # Markdownlint rule overrides
├── lazy-lock.json       # Plugin version lockfile
├── selene.toml          # Lua linter config
└── stylua.toml          # Lua formatter config
```

## Plugins

| Category | Plugin | Purpose |
|----------|--------|---------|
| **Plugin Manager** | [folke/lazy.nvim](https://github.com/folke/lazy.nvim) | Modern plugin manager |
| **Colorscheme** | [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Tokyo Night theme (night style) |
| **LSP** | [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client config |
| | [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/formatter/linter installer |
| | [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason-LSPConfig bridge |
| | [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Tool auto-installer |
| **Autocompletion** | [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| | [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| | [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| | [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer completion source |
| | [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) | Path completion source |
| | [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua require completion |
| **Treesitter** | [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax parsing & highlighting |
| **Fuzzy Finding** | [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | File/string/buffer picker |
| | [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | fzf-native sorter |
| | [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) | Alternative fuzzy finder |
| **Git** | [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) | Git porcelain |
| | [tpope/vim-rhubarb](https://github.com/tpope/vim-rhubarb) | GitHub extensions for fugitive |
| | [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in gutter |
| | [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim) | Diff viewer |
| | [cohama/agit.vim](https://github.com/cohama/agit.vim) | Git history explorer |
| | [ldelossa/gh.nvim](https://github.com/ldelossa/gh.nvim) | GitHub CLI integration |
| **Wiki / Markdown** | [echaya/neowiki.nvim](https://github.com/echaya/neowiki.nvim) | Markdown wiki |
| | [epwalsh/obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) | Obsidian vault support |
| | [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown rendering |
| | [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Live markdown preview |
| **UI** | [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) | Better UI prompts |
| | [folke/noice.nvim](https://github.com/folke/noice.nvim) | Enhanced command line & notifications |
| | [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| | [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO/FIXME highlighting |
| | [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim) | Mini suite (ai, surround, statusline) |
| **Formatting** | [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save |
| | [nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) | LSP-agnostic formatters/linters |
| **Debug** | [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol |
| | [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | DAP UI |
| | [jay-babu/mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) | DAP installer |
| **Terminal** | [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating terminal |
| **AI** | [olimorris/codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) | AI assistant |
| | [ravitemer/mcphub.nvim](https://github.com/ravitemer/mcphub.nvim) | MCP tool integration |
| **Sessions** | [rmagatti/auto-session](https://github.com/rmagatti/auto-session) | Session management |

## Keymaps

### Leader Key: `\`

#### General
| Key | Action |
|-----|--------|
| `<leader>fe` | `:edit ` (wildmenu file open) |
| `<leader>fs` | `:saveas ` |
| `<leader>p` | Paste from system clipboard |
| `<leader>y` | Yank to system clipboard |
| `<leader>z` | Clear search highlight |
| `<leader>nn` | Toggle line numbers |
| `<leader>sf` | Source current file |
| `<leader>ck` | Check for duplicate keymaps |
| `<leader>ph` | Open plugin help under cursor |

#### Window Navigation (Ctrl-based)
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows left/down/up/right |
| `<leader>0` | Close all buffers except current |

#### Window Resize
| Key | Action |
|-----|--------|
| `<F3>` | Decrease vertical width by 5 |
| `<F4>` | Increase vertical width by 5 |

#### Tabs
| Key | Action |
|-----|--------|
| `<leader>tp` | Previous tab |
| `<leader>tn` | Next tab |
| `<leader>tN` | New tab |
| `<leader>tc` | Close tab |

#### Telescope
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fc` | Grep string under cursor |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>km` | Keymaps |
| `<leader>ht` | Help tags in new tab |

#### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gt` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>cf` | Format buffer |
| `<leader>NF` | Format buffer (alias) |
| `<leader>NL` | Lint buffer |

#### Git
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |
| `<leader>gp` | Git push |
| `<leader>ga` | Git add . |
| `<leader>gm` | Git blame |
| `<leader>gl` | Agit log tree |
| `<leader>gh` | Agit file history |
| `<leader>gb` | Git branches (telescope) |
| `<leader>gc` | Git commits (telescope) |
| `<leader>gd` | Diffview open |
| `<leader>gq` | Diffview close |
| `<leader>gls` | Short git log |
| `]c` / `[c` | Next/previous git hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |

#### Wiki / Markdown
| Key | Action |
|-----|--------|
| `<leader>ww` | Open wiki |
| `<leader>wW` | Open wiki (float) |
| `<leader>wT` | Open wiki (new tab) |
| `<leader>tc` | Toggle conceal (markdown) |
| `<leader>tt` | Insert trip template |
| `<F8>` | Toggle conceal (legacy) |

#### Diff
| Key | Action |
|-----|--------|
| `<leader>wd` | Diff this (all windows) |
| `<leader>wD` | Diff off |

#### Spelling
| Key | Action |
|-----|--------|
| `<F5>` | Next spelling error |
| `<F6>` | Spelling suggestions (`z=`) |
| `<F7>` | Add word to dictionary (`zg`) |

#### Terminal
| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<Esc>` | Exit terminal mode |
| `jk` | Exit terminal mode |

#### Debug
| Key | Action |
|-----|--------|
| `<leader><F5>` | Start/continue debugger |
| `<leader><F1>` | Step into |
| `<leader><F2>` | Step over |
| `<leader><F3>` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Conditional breakpoint |
| `<F8>` | Toggle DAP UI |

#### AI Assistant
| Key | Action |
|-----|--------|
| `<leader>cc` | Open CodeCompanion chat |
| `<leader>cz` | Clear chat |
| `<leader>cs` | Send selection to chat |

#### Formatting
| Key | Action |
|-----|--------|
| `<leader>mp` | Format file/range |
| `<leader>mf` | Format selection (visual) |

## Filetype-Specific Settings

### Markdown
- Conceal level: 2
- Spell checking enabled
- Indent: 2 spaces, expand tabs

### Lua
- Indent: 2 spaces, expand tabs

### Jenkinsfile / Groovy
- Files named `*jenkinsfile` or `Jenkinfile*` are set to `groovy` filetype

### Ansible
- `.yml` files are detected as `yaml.ansible`

## LSP Servers

Installed via Mason:
- `ansiblels` — Ansible
- `bashls` — Bash
- `groovyls` — Groovy
- `lua_ls` — Lua (configured to suppress `missing-fields` diagnostic, `vim` global whitelisted)
- `pyright` — Python
- `ruff` — Python (fast linter)
- `html` — HTML

Formatters/tools via Mason:
- `beautysh`, `prettier`, `shellcheck`, `stylua`

## Wiki / Vimwiki

The wiki lives at `~/vimwiki` using Markdown syntax (`.md` files). Powered by **neowiki.nvim** with **render-markdown.nvim** for live rendering. Also supports **obsidian.nvim** for Obsidian vault integration.

## Troubleshooting

If you encounter issues:

1. Run `:checkhealth` to identify problems
2. Run `:Lazy sync` to ensure all plugins are installed
3. Run `:TSUpdate` to update treesitter parsers
4. Check Mason (`:Mason`) for LSP server installation status
5. Check the LSP log: `:lua vim.cmd('tabnew '..vim.lsp.get_log_path())`

### Common Fixes

**Ruby provider warning**: Disabled via `vim.g.loaded_ruby_provider = 0` — Ruby provider is not needed for this config.

**Luarocks warnings**: Rocks support is disabled via `rocks = { enabled = false }` in lazy setup.

**Treesitter parser compilation**: Ensure `tree-sitter-cli` and a C compiler (`gcc`) are installed on your system.

**Markdown formatting**: Uses `prettier`. Install via Mason or your system package manager.
