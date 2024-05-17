local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins = {
--     {
--         "nvim-telescope/telescope.nvim", branch = "0.1.x",
--         dependencies = { "nvim-lua/plenary.nvim" }
--     },
--     {
--         "nvim-lualine/lualine.nvim",
--         requires = { "nvim-tree/nvim-web-devicons" }
--     },
--     {
--
--     }
--     {
--         "hrsh7th/nvim-cmp",
--         event = "InsertEnter",
--         dependencies = {
--             "hrsh7th/cmp-nvim-lsp",
--             "hrsh7th/cmp-buffer",
--         },
--         config = function()
--             -- ...
--         end
--     }
-- }

require("lazy").setup("plugins")
