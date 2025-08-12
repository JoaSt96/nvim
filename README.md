# Neovim Configuration

A modern Neovim configuration with LSP, completion, and productivity plugins.

## Quick Start

Leader key: `<Space>`

## Core Keymaps

### File Operations
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<C-q>` - Quit all
- `<leader>c` - Close buffer

### Window Management
- `<leader>s` - Vertical split
- `<leader>h` - Horizontal split
- `<leader>v` - Close all splits except current
- `<C-h/j/k/l>` - Navigate between windows

### Buffer Management
- `<leader>bn` - Next buffer
- `<leader>bb` - Previous buffer

### Text Manipulation
- `J/K` (Visual) - Move selected text up/down
- `J` (Normal) - Join lines
- `p` (Visual) - Paste without losing clipboard
- `<leader>da` - Delete all marks

### Quick Actions
- `<leader><leader>` - Source current file

## Plugin Keymaps

### File Explorer (nvim-tree)
- `<leader>ee` - Toggle file explorer
- `<leader>ef` - Toggle file explorer on current file
- `<leader>er` - Refresh file explorer
- `<leader>ec` - Collapse file explorer

### File Explorer (Oil)
- `-` - Open parent directory in floating window

### Telescope (Fuzzy Finder)
- `<leader>ff` - Find files
- `<leader>ft` - Live grep (search text)
- `<leader>fh` - Help tags

### Harpoon (File Navigation)
- `<leader>a` - Add file to harpoon
- `<C-a>` - Toggle harpoon menu
- `<C-q>` - Go to harpoon file 1
- `<C-w>` - Go to harpoon file 2
- `<C-e>` - Go to harpoon file 3
- `<C-r>` - Go to harpoon file 4

### Hop (Motion)
- `s` - Hop to word
- `S` - Hop to 2-character combination

### LSP (Language Server)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Go to references
- `gt` - Go to type definition
- `K` - Hover documentation
- `<leader>k` - Signature help
- `<leader>rn` - Rename
- `<leader>ac` - Code action
- `[d` / `]d` - Previous/next diagnostic
- `<leader>e` - Show diagnostic
- `<leader>dl` - Diagnostic location list

### Git
- `<leader>gg` - LazyGit
- `<leader>gb` - Git blame
- `<C-p>` - DiffView open
- `<C-o>` - DiffView close

### Utilities
- `<leader>u` - Undo tree
- `<leader>zz` - Zen mode
- `<leader>zZ` - Zen mode with Twilight
- `<leader>et` - Toggle cloak (hide secrets)
- `<leader>tt` - Toggle terminal

### Completion (Blink.cmp)
- `<C-space>` - Trigger completion
- `<CR>` - Accept completion
- `<Tab>` / `<S-Tab>` - Navigate completions
- `<Up>` / `<Down>` - Navigate completions
- `<C-b>` / `<C-f>` - Scroll documentation

### Supermaven (AI Completion)
- `<Tab>` - Accept AI suggestion
- `<C-]>` - Clear suggestion
- `<C-j>` - Accept word

## Plugin List

### Core
- **lazy.nvim** - Plugin manager
- **mason.nvim** - LSP server installer
- **nvim-lspconfig** - LSP configuration
- **blink.cmp** - Completion engine
- **nvim-treesitter** - Syntax highlighting

### File Management
- **nvim-tree** - File explorer
- **oil.nvim** - Directory editor
- **telescope.nvim** - Fuzzy finder

### Git Integration
- **lazygit.nvim** - Git interface
- **gitsigns.nvim** - Git signs
- **diffview.nvim** - Git diff viewer
- **git.nvim** - Git blame

### Navigation & Motion
- **harpoon** - File navigation
- **hop.nvim** - Easy motion
- **marks.nvim** - Enhanced marks

### UI & Appearance
- **lualine.nvim** - Status line
- **bufferline.nvim** - Buffer tabs
- **alpha-nvim** - Start screen
- **noice.nvim** - UI improvements
- **tokyonight.nvim** - Color scheme
- **zen-mode.nvim** - Distraction-free writing

### Utilities
- **undotree** - Undo history
- **toggleterm.nvim** - Terminal integration
- **autopairs** - Auto-close brackets
- **comment.nvim** - Easy commenting
- **cloak.nvim** - Hide secrets
- **supermaven-nvim** - AI completion

### Development Tools
- **conform.nvim** - Formatting
- **nvim-lint** - Linting
- **trouble.nvim** - Diagnostics
- **todo-comments.nvim** - Todo highlighting

## Configuration Structure

```
lua/stok/
├── core/
│   ├── init.lua        # Core initialization
│   ├── options.lua     # Vim options
│   └── keymaps.lua     # Key mappings
├── plugins/
│   ├── lsp/            # LSP configurations
│   │   ├── mason.lua
│   │   ├── nvim-lspconfig.lua
│   │   └── blink.lua
│   └── *.lua          # Plugin configurations
└── lazy.lua           # Plugin manager setup
```

## Key Features

- **Modern LSP setup** with Mason for easy server management
- **Fast completion** with Blink.cmp
- **Git integration** with multiple tools
- **File navigation** with Telescope and Harpoon
- **Productivity focused** with Zen mode and distraction-free features
- **Hidden system files** (.DS_Store, .git)
- **AI assistance** with Supermaven

## Notes

- Leader key is set to Space
- Configuration uses lazy.nvim for plugin management
- LSP servers are auto-installed via Mason
- Completion works only in code files (disabled in prompts)
- All keymaps are documented with descriptions