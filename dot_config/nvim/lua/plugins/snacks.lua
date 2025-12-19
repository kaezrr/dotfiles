return { -- Fuzzy Finder (files, lsp, etc)
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    picker = {},
    bigfile = {},
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    dashboard = {
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },
  },

  -- See `:help snacks-pickers-sources`
  keys = {
    {
      '<leader>gg',
      function() Snacks.lazygit.open() end,
      desc = 'Open Lazygit',
    },
    {
      '<leader>sh',
      function() Snacks.picker.help() end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function() Snacks.picker.keymaps() end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sf',
      function() Snacks.picker.smart() end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>ss',
      function() Snacks.picker.pickers() end,
      desc = '[S]earch [S]elect Snacks',
    },
    {
      '<leader>sw',
      function() Snacks.picker.grep_word() end,
      desc = '[S]earch current [W]ord',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sg',
      function() Snacks.picker.grep() end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sd',
      function() Snacks.picker.diagnostics() end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sr',
      function() Snacks.picker.resume() end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>s.',
      function() Snacks.picker.recent() end,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      '<leader><leader>',
      function() Snacks.picker.buffers() end,
      desc = '[ ] Find existing buffers',
    },
    {
      '<leader>/',
      function() Snacks.picker.lines {} end,
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>s/',
      function() Snacks.picker.grep_buffers() end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sn',
      function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
      desc = '[S]earch [N]eovim files',
    },
  },
}
