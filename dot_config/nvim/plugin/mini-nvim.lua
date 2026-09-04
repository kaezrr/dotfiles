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

require('mini.files').setup()

vim.keymap.set({ 'n', 'v' }, '<leader>e', function()
  local current_file = vim.api.nvim_buf_get_name(0)
  -- If current file is the dashboard open in pwd
  if vim.bo.filetype == 'ministarter' then current_file = nil end
  if MiniFiles.close() == nil then MiniFiles.open(current_file) end
end)

vim.keymap.set('n', '<leader>n', function() MiniNotify.show_history() end)
