local function setup_lsp()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    }

    local lspconfig = require('lspconfig')

    local default_setup = function(server)
        lspconfig[server].setup({
            handlers = handlers,
            capabilities = capabilities,
        })
    end

    vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
    vim.lsp.inlay_hint.enable(true)

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local opts = { buffer = event.buf }
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
        end
    })

    default_setup("lua_ls")
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            {
                "williamboman/mason.nvim",
                config = function()
                    require('mason').setup()
                end
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require('mason-lspconfig').setup({
                        ensure_installed = { 'lua_ls', 'rust_analyzer' },
                        automatic_installation = true
                    })
                end
            }
        },
        config = setup_lsp
    },
    {
        "folke/neodev.nvim",
        config = function()
            require('neodev').setup({
                override = function(root_dir, library)
                    if root_dir:find("$HOME/.dotfiles/.config/nvim") == 1 then
                        library.enabled = true
                        library.plugins = true
                    end
                end,
            })
        end
    },
}
