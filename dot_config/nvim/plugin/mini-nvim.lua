vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

require('mini.icons').setup()

require('mini.ai').setup { n_lines = 500 }

require('mini.pairs').setup()

require('mini.statusline').setup()

require('mini.starter').setup {
  footer = '',
}

require('mini.notify').setup {
  lsp_progress = { duration_last = 3000 },
}
