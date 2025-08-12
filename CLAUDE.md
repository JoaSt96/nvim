# Claude Code Configuration Context

This file provides context for Claude Code when working with this Neovim configuration.

## Project Overview

This is a personal Neovim configuration with modern LSP, completion, and productivity plugins. The configuration is structured using lazy.nvim plugin manager and follows a modular approach.

## Important Notes for Claude

### Security Considerations
- **NO API KEYS**: This configuration does not contain API keys or secrets
- **Cloak Plugin**: Uses cloak.nvim to hide sensitive information in files
- **File Filters**: .DS_Store, .git, and other system files are hidden
- **Safe for Public**: This configuration is designed to be publicly shareable

### Configuration Structure
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
│       └── *.lua          # Individual plugin configs
```

### Key Technologies Used
- **Plugin Manager**: lazy.nvim
- **LSP**: mason + nvim-lspconfig + blink.cmp
- **File Management**: nvim-tree + oil.nvim + telescope
- **Git**: lazygit + gitsigns + diffview
- **AI Completion**: supermaven-nvim

### Common Tasks

#### Adding New Plugins
1. Create new file in `lua/stok/plugins/`
2. Return plugin specification table
3. Lazy.nvim auto-detects and loads

#### LSP Configuration
- Servers managed via Mason (`lua/stok/plugins/lsp/mason.lua`)
- Manual server setup in `nvim-lspconfig.lua`
- Completion handled by blink.cmp

#### Troubleshooting
- Check `:Lazy` for plugin status
- Use `:Mason` for LSP server management
- Leader key is `<Space>`
- Configuration auto-reloads with `<leader><leader>`

### File Conventions
- All plugin configs return a table/array of plugin specs
- Use descriptive names for keymaps
- Follow lazy.nvim patterns (opts, config, dependencies)
- Keep related functionality grouped

### Recent Fixes Applied
1. Updated Mason repositories to `mason-org/*`
2. Consolidated LSP configuration to avoid duplicates  
3. Fixed blink.cmp configuration for proper completion behavior
4. Added .DS_Store filtering in file explorers
5. Disabled completion in prompts and command mode

### Plugin Dependencies
- Most plugins have proper dependency chains
- Mason installs LSP servers automatically
- Treesitter parsers auto-install
- Icons provided by nvim-web-devicons

### Performance Optimizations
- Lazy loading for most plugins
- LSP diagnostics optimized for performance
- Completion disabled in non-code contexts
- File filters reduce UI clutter

### Maintenance
- `lazy-lock.json` tracks exact plugin versions
- Use `:Lazy update` to update plugins
- Mason handles LSP server updates
- Configuration is modular for easy maintenance


The configuration follows security best practices and is designed to be shared publicly without exposing sensitive information.
