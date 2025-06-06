return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()
    require('mini.pairs').setup()

    -- File system
    local files = require 'mini.files'
    files.setup()
    vim.keymap.set('n', '<leader>e', function() files.open(vim.api.nvim_buf_get_name(0), false) end, { desc = 'Open [E]xplorer' })
  end,
}
