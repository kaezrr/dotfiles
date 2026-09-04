vim.pack.add {
  'https://github.com/folke/snacks.nvim',
}

---@type snacks.Config
require('snacks').setup {
  picker = {},
}

vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit.open() end)
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end)
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end)
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end)
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.pickers() end)
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end)
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end)
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end)
vim.keymap.set('n', '<leader>sr', function() Snacks.picker.resume() end)
vim.keymap.set('n', '<leader>s.', function() Snacks.picker.recent() end)
vim.keymap.set('n', '<leader><leader>', function() Snacks.picker.buffers() end)
vim.keymap.set('n', '<leader>/', function() Snacks.picker.lines {} end)
vim.keymap.set('n', '<leader>s/', function() Snacks.picker.grep_buffers() end)
vim.keymap.set('n', '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end)
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end)
