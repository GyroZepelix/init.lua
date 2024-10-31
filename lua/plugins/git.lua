return {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gs", mode = "n", vim.cmd.Git, desc = "Open Fugitive menu" }
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, key, action, desc)
                    vim.keymap.set(mode, key, action, { buffer = bufnr, desc = desc })
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, "Next Hunk")

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, "Previous Hunk")

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk, "Stage Hunk")
                map('n', '<leader>hr', gitsigns.reset_hunk, "Reset Hunk")
                map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage Hunk (Visual)")
                map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset Hunk (Visual)")
                map('n', '<leader>hS', gitsigns.stage_buffer, "Stage Buffer")
                map('n', '<leader>hu', gitsigns.undo_stage_hunk, "Undo Stage Hunk")
                map('n', '<leader>hR', gitsigns.reset_buffer, "Reset Buffer")
                map('n', '<leader>hp', gitsigns.preview_hunk, "Preview Hunk")
                map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, "Blame Line")
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, "Toggle Blame")
                map('n', '<leader>hd', gitsigns.diffthis, "Diff This")
                map('n', '<leader>hD', function() gitsigns.diffthis('~') end, "Diff This (Against Last Commit)")
                map('n', '<leader>td', gitsigns.toggle_deleted, "Toggle Deleted")

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select Hunk")
            end
        }
    }

