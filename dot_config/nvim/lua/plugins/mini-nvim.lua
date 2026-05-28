return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  version = false,
  lazy = false,
  config = function()
    require('mini.icons').setup()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.pairs').setup()
    require('mini.statusline').setup()
  end,
}
