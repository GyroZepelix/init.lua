function config_telescope()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find Files" })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Find Git Files" })
    vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "List Buffers" })
end

return {
    {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = config_telescope
    }
}
