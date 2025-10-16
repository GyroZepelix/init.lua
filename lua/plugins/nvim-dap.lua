local toggled_scopes = false

return {
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
  },
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      -- configure widgets

      local widgets = require("dap.ui.widgets")

      local scopes = widgets.sidebar(widgets.scopes, {}, "vsplit")
      local frames = widgets.sidebar(widgets.frames, { height = 10 }, "belowright split")

      vim.keymap.set("n", "<leader>dus", scopes.toggle, { desc = "Toggle Scopes" })
      vim.keymap.set("n", "<leader>duf", frames.toggle, { desc = "Toggle Frames" })
      vim.keymap.set("n", "K", widgets.hover, {
        buffer = scopes.buf
      })
    end,
  },
}
