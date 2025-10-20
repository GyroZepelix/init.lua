-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.opt.clipboard = ""
vim.o.winborder = "rounded"
vim.lsp.inlay_hint.enable(false)

vim.api.nvim_create_user_command("HighlightNumbers", function()
  vim.cmd("highlight LineNr guifg=#59637a")
end, { nargs = 0 })
