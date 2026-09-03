vim.pack.add {
  {
    src = 'https://github.com/mikavilpas/yazi.nvim',
    version = vim.version.range '*',
  },
  'https://github.com/nvim-lua/plenary.nvim',
}

require('yazi').setup {
  open_for_directories = true,
  keymaps = {
    show_help = '<f1>',
  },
}

vim.g.loaded_netrwPlugin = 1

vim.keymap.set({ 'n', 'v' }, '-', '<cmd>Yazi<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>-', '<cmd>Yazi cwd<cr>')
