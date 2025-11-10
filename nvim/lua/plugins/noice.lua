return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("noice").setup({
      health = {
        checker = false,
      },
      messages = {
        enable = false,
      },
      popupmenu = {
        enable = false,
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
      cmdline = {
        view = "cmdline",
      },
    })
  end,
}
