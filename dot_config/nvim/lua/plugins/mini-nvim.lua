return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  version = false,
  lazy = false,
  config = function()
    require('mini.icons').setup()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.pairs').setup()
    require('mini.statusline').setup()
    require('mini.files').setup()
  end,
  keys = {
    {
      '<leader>e',
      function() MiniFiles.open(vim.api.nvim_buf_get_name(0), false) end,
      desc = 'Open File Explorer',
    },
  },
}
