return {
    {
        "github/copilot.vim",
        config = function ()
            local copilot_on = false
            vim.cmd("Copilot disable")

            vim.api.nvim_create_user_command("CopilotToggle", function()
                if copilot_on then
                    vim.cmd("Copilot disable")
                    print("Copilot OFF")
                else
                    vim.cmd("Copilot enable")
                    print("Copilot ON")
                end
                copilot_on = not copilot_on
            end, { nargs = 0 })

            vim.keymap.set("n", "<M-c>", ":CopilotToggle<CR>", { noremap = true, silent = true })
        end
    }
}
