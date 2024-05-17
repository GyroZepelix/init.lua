function setup_treesitter()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "rust", "typescript", "markdown", "markdown_inline" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
}
