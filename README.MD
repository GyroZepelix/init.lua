# Neovim Configuration

This is my Neovim configuration. It uses `lazy.nvim` for package management and the `rose-pine` color scheme. Below are the details on how to set it up and the plugins included in this configuration.

## Table of Contents

- [Installation](#installation)
- [Configuration Structure](#configuration-structure)
- [Plugins](#plugins)
  - [Plugin Manager](#plugin-manager)
  - [LSP and Autocompletion](#lsp-and-autocompletion)
  - [UI Enhancements](#ui-enhancements)
  - [Utilities](#utilities)
- [Color Scheme](#color-scheme)

## Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/GyroZepelix/nvim-config.git ~/.config/nvim
   ```

2. **Install Neovim (version 0.10 or higher is required):**
   - [Neovim Installation Guide](https://github.com/neovim/neovim/wiki/Installing-Neovim)

3. **Open Neovim and install plugins:**
   ```sh
   nvim
   ```
   It should automaticly install all of the necessary plugins

### Alternative Installation
You can follow the installation process of `https://github.com/GyroZepelix/.dotfiles` and it will automaticly install this aswell

## Configuration Structure

The configuration files are structured as follows:

```
~/.config/nvim/
├── init.lua
└── lua
    ├── gyro
    │   ├── init.lua
    │   ├── lazy.lua
    │   ├── remap.lua
    │   └── set.lua
    └── plugins
        ├── autopairs.lua
        ├── cmp.lua
        ├── colorscheme.lua
        ├── fugitive.lua
        ├── gitsigns.lua
        ├── lsp.lua
        ├── lualine.lua
        ├── nvim-surround.lua
        ├── telescope.lua
        ├── tmux-navigator.lua
        ├── treesitter.lua
        └── undotree.lua
```

## Plugins

### Plugin Manager

- **[lazy.nvim](https://github.com/folke/lazy.nvim)**: A modern plugin manager for Neovim.

### LSP and Autocompletion

- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: A completion plugin for Neovim.
  - **Dependencies:**
    - `cmp-buffer`
    - `cmp-path`
    - `cmp-nvim-lsp`
    - `cmp-cmdline`
    - `LuaSnip`
    - `cmp_luasnip`
    - `friendly-snippets`

- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: Quickstart configurations for the Neovim LSP client.
  - **Dependencies:**
    - `neoconf.nvim`
    - `mason.nvim`
    - `mason-lspconfig.nvim`

- **[neodev.nvim](https://github.com/folke/neodev.nvim)**: Development setup for Neovim plugins.

### UI Enhancements

- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**: A blazing fast and easy to configure Neovim statusline.
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**: A highly extendable fuzzy finder over lists.
- **[rose-pine](https://github.com/rose-pine/neovim)**: All natural pine, faux fur and a bit of soho vibes for the classy minimalist.

### Utilities

- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)**: A plugin for auto-closing and auto-completing pairs.
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**: Git integration for buffers.
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)**: A Git wrapper so awesome, it should be illegal.
- **[nvim-surround](https://github.com/kylechui/nvim-surround)**: A plugin for surrounding selections with characters.
- **[tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)**: Seamless navigation between tmux panes and Vim splits.
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: Neovim Treesitter configurations and abstraction layer.
- **[undotree](https://github.com/mbbill/undotree)**: A visual undo history for Neovim.

## Color Scheme

The color scheme used in this configuration is `rose-pine`. You can change the color scheme by modifying the `colorscheme.lua` file in the `lua/plugins` directory.

```lua
-- lua/plugins/colorscheme.lua
vim.cmd('colorscheme rose-pine')
```

---

Feel free to explore and customize the configuration to suit your needs. Contributions and suggestions are welcome!
