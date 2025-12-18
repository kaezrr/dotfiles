-- Move selected region up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Center screen on some actions
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Paste without rewriting buffer
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set({ 'n', 'v', 'i' }, '<C-c>', '<Esc>')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader>w', '<CMD>update<CR>', { desc = 'Save buffer' })
vim.keymap.set('n', '<leader>q', '<CMD>quit<CR>', { desc = 'Quit buffer' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Moving throught snippets
vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if vim.snippet.active { direction = 1 } then
    return '<Cmd>lua vim.snippet.jump(1)<CR>'
  else
    return ''
  end
end, { desc = 'Snippet Next', expr = true, silent = true })

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if vim.snippet.active { direction = -1 } then
    return '<Cmd>lua vim.snippet.jump(-1)<CR>'
  else
    return ''
  end
end, { desc = 'Snippet Prev', expr = true, silent = true })
