vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

require('mini.icons').setup()
require('mini.files').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.ai').setup { n_lines = 500 }
require('mini.notify').setup { lsp_progress = { duration_last = 3000 } }

vim.keymap.set('n', '<leader>e', function()
  if MiniFiles.close() == nil then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
end)

vim.keymap.set('n', '<leader>n', function() MiniNotify.show_history() end)
