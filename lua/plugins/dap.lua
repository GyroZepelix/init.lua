return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require "dap"
            local ui = require "dapui"

            require("dapui").setup()
            require("dap-go").setup()

            require("nvim-dap-virtual-text").setup {}

            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Run to Cursor" })

            vim.keymap.set("n", "<leader>gk", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F6>", dap.step_into)
            vim.keymap.set("n", "<F7>", dap.step_over)
            vim.keymap.set("n", "<F8>", dap.step_out)
            vim.keymap.set("n", "<F9>", dap.step_back)
            vim.keymap.set("n", "<F10>", dap.restart)
            vim.keymap.set("n", "<F11>", dap.stop)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end

            -------- Go Debugger ---------
            dap.adapters.dlv_spawn = function(cb)
                local stdout = vim.loop.new_pipe(false)
                local handle
                local pid_or_err
                local port = 38697
                local opts = {
                    stdio = { nil, stdout },
                    args = { "dap", "-l", "127.0.0.1:" .. port },
                    detached = true
                }
                handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
                    stdout:close()
                    handle:close()
                    if code ~= 0 then
                        print('dlv exited with code', code)
                    end
                end)
                assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
                stdout:read_start(function(err, chunk)
                    assert(not err, err)
                    if chunk then
                        vim.schedule(function()
                            --- You could adapt this and send `chunk` to somewhere else
                            require('dap.repl').append(chunk)
                        end)
                    end
                end)
                -- Wait for delve to start
                vim.defer_fn(
                    function()
                        cb({ type = "server", host = "127.0.0.1", port = port })
                    end,
                    100)
            end
            dap.configurations.go = {
                {
                    type = 'dlv_spawn',
                    name = 'Launch dlv & file',
                    request = 'launch',
                    program = "${file}",
                },
            }
            vim.api.nvim_create_user_command(
                'DelveTest',
                function()
                    require('dap-go').debug_test()
                end,
                { desc = "Debug the closest method above the cursor" }
            )
            vim.api.nvim_create_user_command(
                'DelveLast',
                function()
                    require('dap-go').debug_last_test()
                end,
                { desc = "Rerun last run test with DelveTest" }
            )
        end
    }
}
