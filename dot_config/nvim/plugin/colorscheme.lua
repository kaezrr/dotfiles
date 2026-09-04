vim.pack.add {
  {
    src = 'https://github.com/rebelot/kanagawa.nvim',
    name = 'kanagawa',
  },
}

require('kanagawa').setup {
  transparent = true,
}

vim.cmd.colorscheme 'kanagawa-wave'
vim.cmd.hi 'Comment gui=none'
