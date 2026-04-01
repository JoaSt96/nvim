# Claude Code Configuration Context

This is a minimal, fast Neovim configuration focused on code review with LSP support.

## Configuration Structure
```
/Users/joaquinstok/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin versions (auto-generated)
├── lua/stok/
│   ├── lazy.lua            # Plugin manager setup
│   ├── core/
│   │   ├── init.lua        # Loads core modules
│   │   ├── options.lua     # Vim options & settings
│   │   └── keymaps.lua     # Custom key mappings
│   └── plugins/
│       ├── lsp/            # LSP-related plugins
│       │   ├── mason.lua   # LSP server installer
│       │   ├── nvim-lspconfig.lua  # LSP configuration
│       │   └── blink.lua   # Completion engine
│       ├── init.lua        # plenary.nvim (utility dependency)
│       ├── colorscheme.lua # tokyonight
│       ├── telescope.lua   # Fuzzy finder (fzf)
│       ├── treesitter.lua  # Syntax highlighting
│       ├── gitsigns.lua    # Git gutter indicators
│       ├── lazygit.lua     # Git UI
│       ├── hop.lua         # Quick jumping
│       └── formatter.lua   # Prettier/stylua
```

## Plugins (13 total)
- **Plugin Manager**: lazy.nvim
- **LSP**: mason + nvim-lspconfig + blink.cmp
- **Fuzzy Finder**: telescope + fzf-native
- **Git**: lazygit + gitsigns
- **Navigation**: hop.nvim
- **Formatting**: conform.nvim (prettier, stylua)
- **Syntax**: nvim-treesitter
- **Theme**: tokyonight

## Key Bindings
- Leader: `<Space>`
- `<leader>ff` — Find files
- `<leader>ft` — Live grep
- `<leader>gg` — LazyGit
- `s` / `S` — Hop word / 2-char
- `Ctrl+Space` — Trigger completion
- `gd` — Go to definition
- `K` — Hover docs

## LSP Configuration
- Servers: lua_ls, ts_ls (via `vim.lsp.config` + `vim.lsp.enable`)
- Mason installs servers automatically
- Completion via blink.cmp with LSP, path, snippets, buffer sources
- Format on save via conform.nvim (2s timeout)
