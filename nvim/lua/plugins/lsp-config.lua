return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        enabled = false,
      },
      ts_ls = {
        enabled = false,
      },
      vtsls = {
        enabled = false,
      },
    },
  },
}
