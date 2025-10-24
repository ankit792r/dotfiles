return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        globalstatus = true,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {
          "checkhealth",
          "snacks_dashboard",
          "NeogitConsole",
          "NeogitStatus",
          statusline = {},
          winbar = {},
        },
        theme = {
          normal = {
            a = { fg = "#000000", bg = "#89b4fa", gui = "bold" }, -- mode section color
            b = { fg = "NONE", bg = "NONE" },
            c = { fg = "NONE", bg = "NONE" },
          },
          insert = { a = { fg = "#000000", bg = "#a6e3a1", gui = "bold" } },
          visual = { a = { fg = "#000000", bg = "#f9e2af", gui = "bold" } },
          replace = { a = { fg = "#000000", bg = "#f38ba8", gui = "bold" } },
          inactive = {
            a = { fg = "NONE", bg = "NONE" },
            b = { fg = "NONE", bg = "NONE" },
            c = { fg = "NONE", bg = "NONE" },
          },
        },
      },
      refresh = { statusline = 60 },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "filetype" },
        lualine_z = { "progress", "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })

    -- Create a centered filename in the middle of the statusline
    -- Use Lualine's `lualine_c` in the middle section
    require("lualine").setup({
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1, -- show relative path
            color = { fg = "NONE", bg = "NONE" },
            padding = { left = 1, right = 1 },
          },
        },
      },
    })
  end,
}
