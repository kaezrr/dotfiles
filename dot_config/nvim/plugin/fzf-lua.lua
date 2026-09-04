vim.pack.add { 'https://github.com/ibhagwan/fzf-lua' }

require('fzf-lua').setup()
require('fzf-lua').register_ui_select()

vim.keymap.set('n', '<leader>sh', function() FzfLua.helptags() end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', function() FzfLua.keymaps() end)
vim.keymap.set('n', '<leader>sf', function() FzfLua.files() end)
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() FzfLua.grep_cword() end)
vim.keymap.set('n', '<leader>sg', function() FzfLua.live_grep() end)
vim.keymap.set('n', '<leader>sd', function() FzfLua.diagnostics_workspace() end)
vim.keymap.set('n', '<leader>sr', function() FzfLua.resume() end)
vim.keymap.set('n', '<leader><leader>', function() FzfLua.buffers() end)
vim.keymap.set('n', '<leader>sn', function() FzfLua.files { cwd = vim.fn.stdpath 'config' } end)
