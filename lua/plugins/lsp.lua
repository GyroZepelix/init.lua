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
            -- vim.keymap.set('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions({initial_mode = "normal})<insert>')
            vim.keymap.set('n', 'gd', function()
                local telescope = require("telescope.builtin")
                telescope.lsp_definitions({
                    initial_mode = "insert",
                })
            end, opts)
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
                        ensure_installed = { 'lua_ls' },
                        automatic_installation = true
                    })
                end
            }
        },
        config = setup_lsp
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
    -- {
    --     "simrat39/rust-tools.nvim",
    --     config = function()
    --         local rt = require("rust-tools")
    --         local mason_registry = require("mason-registry")
    --
    --         local codelldb = mason_registry.get_package("codelldb")
    --         local extention_path = codelldb:get_install_path() .. "/extentions"
    --         local codelldb_path = extention_path .. "adapter/codelldb"
    --
    --         rt.setup({
    --             dap = {
    --                 adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    --             },
    --             server = {
    --                 capabilities = require("cmp_nvim_lsp").default_capabilities(),
    --                 on_attach = function(_, bufnr)
    --                     vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
    --                     vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    --                 end,
    --             },
    --             tools = {
    --                 hover_actions = {
    --                     auto_focus = true,
    --                 },
    --                 float_win_config = {
    --                     border = "rounded",
    --                 },
    --             }
    --         })
    --     end
    -- },
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
