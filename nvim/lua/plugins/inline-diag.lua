return {
  "rachartier/tiny-inline-diagnostic.nvim",
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "powerline",
      options = {
        multilines = {
          enabled = true,
          always_show = true,
        },
        break_line = {
          enabled = false,
          after = 20,
        },
        overflow = {
            mode = "wrap",
            padding = 8,
        },
        show_all_diags_on_cursorline = true,
        enable_on_insert = false,
      },
    })
  end,
}
