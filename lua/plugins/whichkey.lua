return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {

        }, 
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
            { "<leader>pv", vim.cmd.Ex, desc = "Open Project View" },

            { "<C-d>", "<C-d>zz", desc = "Scroll down and center" },
            { "<C-u>", "<C-u>zz", desc = "Scroll up and center" },

            { "n", "nzzzv", mode = "n", desc = "Next search result centered" },
            { "N", "Nzzzv", mode = "n", desc = "Previous search result centered" },

            { "<leader>p", "\"_dP", mode = "x", desc = "Paste without yanking" },

            { "<leader>y", "\"+y", mode = "n", desc = "Yank to clipboard" },
            { "<leader>y", "\"+y", mode = "v", desc = "Yank selection to clipboard" },
            { "<leader>Y", "\"+Y", mode = "n", desc = "Yank line to clipboard" },

            { "<leader>d", "\"_d", mode = "n", desc = "Delete without yanking" },
            { "<leader>d", "\"_d", mode = "v", desc = "Delete selection without yanking" },

            { "<C-c>", "<Esc>", mode = "i", desc = "Alternative to Escape" },

            {
                "<leader>s",
                ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
                mode = "n",
                desc = "Replace word under cursor"
            }

        }
    },
}
