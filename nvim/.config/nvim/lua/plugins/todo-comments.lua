return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = { 'BufRead', 'BufNewFile' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      '<leader>st',
      function() Snacks.picker.todo_comments() end,
      desc = '[S]earch [T]odos',
    },
  },
}
