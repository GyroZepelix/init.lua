-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.opt.clipboard = ""
vim.o.winborder = "rounded"
vim.lsp.inlay_hint.enable(false)
--
-- vim.diagnostic.config({
--   virtual_text = false, -- Optional: disable inline text to reduce clutter
--   signs = true, -- Keep signs in the sign column
--   underline = true, -- Underline problematic code
--   float = {
--     focusable = false,
--     style = "minimal",
--     border = "rounded",
--     source = "if_many", -- Show the diagnostic source (e.g., gopls)
--     header = "",
--     prefix = "",
--   },
-- })
