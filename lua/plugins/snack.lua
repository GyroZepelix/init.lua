return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<c-p>",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
    },
    opts = {
      dashboard = {
        preset = {
          header = [[
 ▓█████▄ ▓█████ ▓█████▄  ▄████▄   ▄▄▄     ▄▄▄█████▓
▒██▀ ██▌▓█   ▀ ▒██▀ ██▌▒██▀ ▀█  ▒████▄   ▓  ██▒ ▓▒
░██   █▌▒███   ░██   █▌▒▓█    ▄ ▒██  ▀█▄ ▒ ▓██░ ▒░
░▓█▄   ▌▒▓█  ▄ ░▓█▄   ▌▒▓▓▄ ▄██▒░██▄▄▄▄██░ ▓██▓ ░ 
░▒████▓ ░▒████▒░▒████▓ ▒ ▓███▀ ░ ▓█   ▓██▒ ▒██▒ ░ 
 ▒▒▓  ▒ ░░ ▒░ ░ ▒▒▓  ▒ ░ ░▒ ▒  ░ ▒▒   ▓▒█░ ▒ ░░   
 ░ ▒  ▒  ░ ░  ░ ░ ▒  ▒   ░  ▒     ▒   ▒▒ ░   ░    
 ░ ░  ░    ░    ░ ░  ░ ░          ░   ▒    ░      
   ░       ░  ░   ░    ░ ░            ░  ░        
 ░              ░      ░
]],
        },
      },
      lazygit = {
        enabled = true,
      },
      notifier = {
        enabled = false,
      },
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
          },
          explorer = {
            jump = {
              close = true,
            },
            layout = {
              preset = "default",
            },
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
