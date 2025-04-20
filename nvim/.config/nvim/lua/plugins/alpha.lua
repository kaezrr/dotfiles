return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require 'alpha.themes.dashboard'
    -- Define and set highlight groups for each logo line
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo1', { fg = '#641220' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo2', { fg = '#6e1423' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo3', { fg = '#85182a' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo4', { fg = '#a11d33' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo5', { fg = '#a71e34' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo6', { fg = '#b21e35' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo7', { fg = '#bd1f36' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo8', { fg = '#c71f37' })
    vim.api.nvim_set_hl(0, 'NeovimDashboardLogo9', { fg = '#da1e37' })
    dashboard.section.header.type = 'group'
    dashboard.section.header.val = {
      {
        type = 'text',
        val = '           .*-.         ',
        opts = { hl = 'NeovimDashboardLogo1', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '       -:   @+  .=      ',
        opts = { hl = 'NeovimDashboardLogo1', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '     .*-    @=    #-    ',
        opts = { hl = 'NeovimDashboardLogo2', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '    +@-     @=     %*.  ',
        opts = { hl = 'NeovimDashboardLogo2', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '   =@%:     @=     *@*  ',
        opts = { hl = 'NeovimDashboardLogo3', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '    .+@#.   @=   =@*:   ',
        opts = { hl = 'NeovimDashboardLogo3', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '       =%*. @= -%*.     ',
        opts = { hl = 'NeovimDashboardLogo4', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '         =%*@##+.       ',
        opts = { hl = 'NeovimDashboardLogo4', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '          =@@@%-        ',
        opts = { hl = 'NeovimDashboardLogo5', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '        +@#:@*=%#:      ',
        opts = { hl = 'NeovimDashboardLogo5', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '     .+@%-  @+  =@#-    ',
        opts = { hl = 'NeovimDashboardLogo6', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '   .+@%-    @+   .+@#:  ',
        opts = { hl = 'NeovimDashboardLogo6', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '   =@@=     @+    :#@*  ',
        opts = { hl = 'NeovimDashboardLogo7', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '     =%%-   @+  .*@*.   ',
        opts = { hl = 'NeovimDashboardLogo7', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '       =%%- @+ +@#:     ',
        opts = { hl = 'NeovimDashboardLogo8', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '         =%%@%@#:       ',
        opts = { hl = 'NeovimDashboardLogo8', shrink_margin = false, position = 'center' },
      },
      {
        type = 'text',
        val = '           -#*:         ',
        opts = { hl = 'NeovimDashboardLogo9', shrink_margin = false, position = 'center' },
      },
    }

    dashboard.section.buttons.val = {
      dashboard.button('f', ' ' .. ' Find file', '<cmd>lua Snacks.picker.smart()<cr>'),
      dashboard.button('r', ' ' .. ' Recent files', '<cmd>lua Snacks.picker.recent()<cr>'),
      dashboard.button('c', ' ' .. ' Config', "<cmd>lua Snacks.picker.files { cwd = vim.fn.stdpath 'config' }<cr>"),
      dashboard.button('u', '󰒲 ' .. ' Update', '<cmd>Lazy sync<cr>'),
      dashboard.button('q', ' ' .. ' Quit', '<cmd>qa<cr>'),
    }
    vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#311B92' })
    vim.api.nvim_set_hl(0, 'AlphaButtons', { fg = '#D1C4E9' })
    vim.api.nvim_set_hl(0, 'AlphaShortcut', { fg = '#8BC34A' })
    vim.api.nvim_set_hl(0, 'AlphaFooter', { fg = '#edd691' })

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'
    dashboard.opts.layout[1].val = 3
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'AlphaReady',
        callback = function()
          require('lazy').show()
        end,
      })
    end

    require('alpha').setup(dashboard.opts)

    vim.api.nvim_create_autocmd('User', {
      once = true,
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
