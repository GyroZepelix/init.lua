return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      -- bound to <caps>+hjkl in my kanata dotfiles
      { "<Left>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<Down>", "<cmd>TmuxNavigateDown<cr>" },
      { "<Up>", "<cmd>TmuxNavigateUp<cr>" },
      { "<Right>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },
}
