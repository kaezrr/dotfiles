return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  ft = { 'markdown' },
  keys = {
    {
      '<leader>tm',
      function() require('render-markdown').buf_toggle() end,
      desc = '[T]oggle [M]arkdown',
    },
  },
}
