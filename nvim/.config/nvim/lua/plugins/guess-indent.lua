-- lua/plugins/guess-indent.lua (for example)
return {
  'nmac427/guess-indent.nvim',
  event = 'BufReadPost',
  config = function()
    require('guess-indent').setup {}
  end,
}
