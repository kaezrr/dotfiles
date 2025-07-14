return {
  'rachartier/tiny-inline-diagnostic.nvim',
  config = function()
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
  end,
}
