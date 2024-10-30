return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",       -- source for text in buffer
            "hrsh7th/cmp-path",         -- source for file system paths
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",         -- snippet engine
            "onsails/lspkind.nvim",
            -- "saadparwaiz1/cmp_luasnip", -- for autocompletion
            -- "rafamadriz/friendly-snippets", -- useful snippets
        },
        config = function()
            local cmp = require 'cmp'
            local lspkind = require 'lspkind'
            local luasnip = require 'luasnip'
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
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
                    ['<c-k>'] = cmp.mapping(function ()
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" })
                }),
                sources = cmp.config.sources({
                    { name = 'codeium' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol', -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        -- can also be a function to dynamically calculate max width such as 
                        -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                        symbol_map = { Codeium = "", },
                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function (entry, vim_item)
                            return vim_item
                        end
                    })
                }
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        config = function ()
            ls = require('luasnip')

            ls.config.set_config {
                history = true,
                updateevents = "TextChanged, TextChangedI",
                enable_autosnippets = true,
                -- ext_opts = {
                --     [types.choiceNode] = {
                --         active = {
                --             virt_text = { { "<-", "Error" } },
                --         }
                --     }
                -- }
            }
        end
    }

    -- {
    --     "Exafunction/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function()
    --         require("codeium").setup({
    --             enable_chat = true
    --         })
    --     end
    -- }
}
