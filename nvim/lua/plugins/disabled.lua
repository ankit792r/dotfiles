return {
  -- disable trouble
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.diagnostics = opts.diagnostics or {}
      opts.diagnostics.virtual_text = false
    end,
  },
}
