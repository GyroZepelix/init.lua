# Neovim Configuration

A modern Neovim configuration built with `lazy.nvim` for efficient plugin management. This configuration focuses on developer productivity with comprehensive LSP support, debugging capabilities, and a clean interface.

## Features

- Fast startup with lazy loading via `lazy.nvim`
- Full LSP support with Mason for language server management
- Integrated debugging with nvim-dap (Go debugging ready)
- Modern file exploration with Neo-tree
- Powerful fuzzy finding with Telescope
- Advanced syntax highlighting with Treesitter
- Database integration with vim-dadbod
- Smart editing with autopairs and surround
- Intuitive keybindings with which-key documentation

## Requirements

- **Neovim 0.10+** (required)
- **Git** (for plugin management)
- **Node.js** (for some LSP servers)
- **Go** (optional, for Go debugging with delve)
- **ripgrep** (recommended, for better search performance)
- **fd** (optional, for faster file finding)

## Installation

### Quick Install

```bash
# Backup existing configuration (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone https://github.com/GyroZepelix/nvim-config.git ~/.config/nvim

# Start Neovim - plugins will install automatically
nvim
```

## Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── .luarc.json                # Lua language server configuration
├── lazy-lock.json             # Plugin version lock file
└── lua/
    ├── config/
    │   ├── init.lua           # Main configuration loader
    │   ├── lazy.lua           # Lazy.nvim setup and plugin imports
    │   ├── remap.lua          # Custom key mappings
    │   └── set.lua            # Vim options and settings
    └── plugins/
        ├── dap.lua            # Debug Adapter Protocol setup
        ├── file-exploration.lua # Neo-tree file explorer
        ├── git.lua            # Git integration (Fugitive + Gitsigns)
        ├── lsp.lua            # Language Server Protocol configuration
        ├── nvimdevelopment.lua # Neovim development tools
        ├── nvimsurround-autopairs.lua # Text editing enhancements
        ├── sudo.lua           # Sudo file editing support
        ├── telescope.lua      # Fuzzy finder configuration
        ├── theme.lua          # Theme and statusline
        ├── tmux-navigator.lua # Tmux integration
        ├── treesitter.lua     # Syntax highlighting
        ├── undotree.lua       # Undo history visualization
        └── whichkey.lua       # Keybinding documentation
```

## Plugins

### Core & Plugin Management
- **lazy.nvim** - Modern plugin manager with lazy loading

### LSP & Development
- **lsp-zero.nvim** - LSP configuration framework
- **nvim-lspconfig** - LSP client configurations
- **mason.nvim** - LSP server installer
- **mason-lspconfig.nvim** - Mason integration
- **nvim-cmp** - Autocompletion engine
- **nvim-treesitter** - Syntax highlighting

### Debugging
- **nvim-dap** - Debug Adapter Protocol client
- **nvim-dap-ui** - Debug UI
- **nvim-dap-go** - Go debugging support
- **nvim-dap-virtual-text** - Virtual text debug info

### File Management & Navigation
- **neo-tree.nvim** - Modern file explorer
- **telescope.nvim** - Fuzzy finder
- **vim-tmux-navigator** - Seamless tmux navigation

### Git Integration
- **vim-fugitive** - Git wrapper
- **gitsigns.nvim** - Git decorations

### UI & Theme
- **dracula.nvim** - Dark theme
- **lualine.nvim** - Statusline
- **which-key.nvim** - Keybinding helper

### Editing Enhancements
- **nvim-autopairs** - Auto-close brackets
- **nvim-surround** - Surround text objects
- **undotree** - Undo history visualizer

### Database
- **vim-dadbod** - Database interface
- **vim-dadbod-ui** - Database UI
- **vim-dadbod-completion** - SQL completion

### Utilities
- **vim-suda** - Sudo file editing
- **lazydev.nvim** - Neovim development setup
- **neoconf.nvim** - Configuration management

## Key Mappings

### Leader Keys
- **Leader**: `<Space>`
- **Local Leader**: `\`

### Essential Mappings

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>pv` | Normal | `:Ex` | Open file explorer |
| `<leader>?` | Normal | WhichKey | Show buffer keymaps |

### Navigation & Movement
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-d>` | Normal | `<C-d>zz` | Scroll down and center |
| `<C-u>` | Normal | `<C-u>zz` | Scroll up and center |
| `n` | Normal | `nzzzv` | Next search result (centered) |
| `N` | Normal | `Nzzzv` | Previous search result (centered) |

### Clipboard Operations
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>y` | Normal/Visual | `"+y` | Yank to system clipboard |
| `<leader>Y` | Normal | `"+Y` | Yank line to system clipboard |
| `<leader>p` | Visual | `"_dP` | Paste without yanking |
| `<leader>d` | Normal/Visual | `"_d` | Delete without yanking |

### Telescope (Fuzzy Finder)
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>pf` | Normal | Find Files | Search project files |
| `<C-p>` | Normal | Git Files | Search git tracked files |
| `<leader>ps` | Normal | Live Grep | Search text in project |
| `<leader>pb` | Normal | Buffers | List open buffers |

### LSP Features
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `K` | Normal | Hover | Show documentation |
| `gd` | Normal | Definition | Go to definition (Telescope) |
| `gD` | Normal | Declaration | Go to declaration |
| `gi` | Normal | Implementation | Go to implementation |
| `go` | Normal | Type Definition | Go to type definition |
| `gr` | Normal | References | Find references |
| `gl` | Normal | Diagnostics | Show diagnostics |
| `<F2>` | Normal | Rename | Rename symbol |
| `<F3>` | Normal/Visual | Format | Format code |
| `<leader>a` | Normal | Code Actions | Show code actions |

### Debugging (DAP)
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>b` | Normal | Toggle Breakpoint | Set/remove breakpoint |
| `<leader>gb` | Normal | Run to Cursor | Run to cursor position |
| `<leader>gk` | Normal | Evaluate | Evaluate expression |
| `<F5>` | Normal | Continue | Continue execution |
| `<F6>` | Normal | Step Into | Step into function |
| `<F7>` | Normal | Step Over | Step over line |
| `<F8>` | Normal | Step Out | Step out of function |
| `<F9>` | Normal | Step Back | Step backwards |
| `<F10>` | Normal | Restart | Restart debugging |

### Git Integration
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>gs` | Normal | Git Status | Open Fugitive |
| `]c` | Normal | Next Hunk | Next git change |
| `[c` | Normal | Previous Hunk | Previous git change |
| `<leader>hs` | Normal/Visual | Stage Hunk | Stage changes |
| `<leader>hr` | Normal/Visual | Reset Hunk | Reset changes |
| `<leader>hp` | Normal | Preview Hunk | Preview changes |
| `<leader>hb` | Normal | Blame Line | Show git blame |
| `<leader>hd` | Normal | Diff This | Show diff |

### File Explorer (Neo-tree)
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>pe` | Normal | Reveal | Open file explorer |
| `Z` | Normal | Expand All | Expand all subnodes |

### Utilities
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>u` | Normal | Undotree | Open undo history |
| `<leader>s` | Normal | Search Replace | Replace word under cursor |
| `<C-c>` | Insert | Escape | Alternative to Escape |

## Language Server Setup

The configuration automatically installs and configures these language servers:

- **Lua** (`lua_ls`) - Lua development
- **Rust** (`rust_analyzer`) - Rust development  
- **Go** (`gopls`) - Go development
- **Systemd** (`systemd_ls`) - Systemd unit files

### Adding New Language Servers

1. Update the `ensure_installed` list in `lua/plugins/lsp.lua`:
```lua
ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "systemd_ls", "your_new_server" },
```

2. Restart Neovim - Mason will automatically install the new server.

## Debugging Setup

### Go Debugging

The configuration includes full Go debugging support with `delve`:

1. **Install delve**:
```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

2. **Available commands**:
   - `:DelveTest` - Debug the closest test method
   - `:DelveLast` - Rerun last test debug session

3. **Debug workflow**:
   - Set breakpoints with `<leader>b`
   - Start debugging with `<F5>`
   - Use step commands (`<F6>`, `<F7>`, `<F8>`)
   - Evaluate expressions with `<leader>gk`

## Database Integration

Access databases directly from Neovim with vim-dadbod:

1. **Set up connection**: Use `:DB` command or dadbod-ui
2. **Execute queries**: Select SQL and execute
3. **Autocompletion**: SQL completion available in `.sql` files

## Customization

### Changing Theme

Edit `lua/plugins/theme.lua`:
```lua
return {
    {
        'your-theme/nvim',
        config = function ()
            vim.cmd('colorscheme your-theme')
        end
    }
}
```

### Adding Custom Keybindings

Add to `lua/config/remap.lua`:
```lua
vim.keymap.set("n", "<your-key>", "<your-command>", { desc = "Description" })
```

### Modifying Settings

Edit `lua/config/set.lua` for Vim options:
```lua
vim.opt.your_option = value
```

## Troubleshooting

### Plugin Issues
```bash
# Remove lazy-lock.json and reinstall
rm ~/.config/nvim/lazy-lock.json
nvim --headless +q  # This will reinstall plugins
```

### LSP Issues
```bash
# Check LSP status
:LspInfo

# Reinstall language servers
:Mason
```

### Debugging Issues
```bash
# Check DAP configuration
:lua require('dap').configurations

# Verify delve installation
dlv version
```

## Contributing

Feel free to report issues, suggest improvements, or submit pull requests.

## License

This configuration is open source. Feel free to use, modify, and share.
