return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {},
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "tpope/vim-dadbod",
            "kristijanhusak/vim-dadbod-completion",
            "kristijanhusak/vim-dadbod-ui",
        },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'vim-dadbod-completion' },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
        keys = {
            { "<C-b>",     desc = "Scroll Docs Up",     mode = "i" },
            { "<C-f>",     desc = "Scroll Docs Down",   mode = "i" },
            { "<C-Space>", desc = "Trigger Completion", mode = "i" },
            { "<C-e>",     desc = "Abort Completion",   mode = "i" },
            { "<Tab>",     desc = "Confirm Selection",  mode = "i" },
        },

    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        init = function()
            -- Reserve a space in the gutter
            -- This will avoid an annoying layout shift in the screen
            vim.opt.signcolumn = 'yes'
            vim.lsp.inlay_hint.enable(true)
        end,
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )
            lsp_defaults.handlers = vim.tbl_deep_extend(
                'force',
                lsp_defaults.handlers,
                { ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }) }
            )


            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Show Error", buffer = event.buf })
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show Hover Info", buffer = event.buf })
                    vim.keymap.set('n', 'gd', function()
                        require("telescope.builtin").lsp_definitions({ initial_mode = "insert" })
                    end, { desc = "Go to Definition (Telescope)", buffer = event.buf })

                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to Declaration", buffer = event.buf })
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
                        { desc = "Go to Implementation", buffer = event.buf })
                    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition,
                        { desc = "Go to Type Definition", buffer = event.buf })
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Find References", buffer = event.buf })

                    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = "Rename Symbol", buffer = event.buf })
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                        { desc = "Format Code", buffer = event.buf })
                    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action,
                        { desc = "Code Actions", buffer = event.buf })
                end
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(event)
                    local id = vim.tbl_get(event, 'data', 'client_id')
                    local client = id and vim.lsp.get_client_by_id(id)
                    if client == nil then
                        return
                    end

                    -- make sure there is at least one client with formatting capabilities
                    if client.supports_method('textDocument/formatting') then
                        require('lsp-zero').buffer_autoformat()
                    end
                end
            })

            require('mason-lspconfig').setup({
                ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "systemd_ls" },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                }
            })
        end
    }
}
