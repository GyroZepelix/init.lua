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
            -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gd', function()
                local telescope = require("telescope.builtin")
                telescope.lsp_definitions({
                    initial_mode = "insert",
                })
            end, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
            -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', 'gr', function ()
                local telescope = require("telescope.builtin")
                telescope.lsp_references({
                    initial_mode = "insert",
                })

            end, opts)
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
        end
    })

    default_setup("lua_ls")
    default_setup("gradle_ls")
    require("java").setup({
        jdk = {
            auto_install = false
        },
    }
    )

    -- setup lombok 💀
    local jdtls_install = require('mason-registry').get_package('jdtls'):get_install_path()
    local path = {}
    path.java_agent = jdtls_install .. '/lombok.jar'
    path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')
    if vim.fn.has('mac') == 1 then
        path.platform_config = jdtls_install .. '/config_mac'
    elseif vim.fn.has('unix') == 1 then
        path.platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has('win32') == 1 then
        path.platform_config = jdtls_install .. '/config_win'
    end
    path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'
    local data_dir = path.data_dir .. '/' ..  vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local jdtls_cmd = {
        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. path.java_agent,
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        path.launcher_jar,
        '-configuration',
        path.platform_config,
        '-data',
        data_dir,
    }
    lspconfig["jdtls"].setup({
        handlers = handlers,
        capabilities = capabilities,
        cmd = jdtls_cmd
    })

    -- Advance setup
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/neoconf.nvim",
                cmd = "Neoconf",
                config = false,
                dependencies = { "nvim-lspconfig" }
            },
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
                        ensure_installed = { 'lua_ls' },
                        automatic_installation = true
                    })
                end
            }
        },
        config = setup_lsp
    },
    {
        "nvim-java/nvim-java",
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        lazy = false,
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    float_win_config = {
                        border = "rounded",
                    },
                    hover_actions = {
                        auto_focus = true,
                    }
                },
                server = {
                    on_attach = function(client, bufnr)
                        local opts = { silent = true, buffer = bufnr }

                        vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp('codeAction') end, opts)
                    end,
                    -- default_settings = {
                    --     ['rust-analyzer'] = {
                    --
                    --     }
                    -- }
                },
                dap = {

                }
            }
        end
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
