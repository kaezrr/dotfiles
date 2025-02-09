--     ____  __
--    |    |/ _|____    ____ _______________
--    |      < \__  \ _/ __ \\___   /\_  __ \
--    |    |  \ / __ \\  ___/ /    /  |  | \/
--    |____|__ (____  /\___  >_____ \ |__|
--        \/    \/     \/      \/
--
--    Courtesy to kickstart.nvim !!!

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
require 'options'

-- [[ Basic and high powered keybinds ]]
require 'keybinds'

-- [[ Bootstrap Lazy package manager and install plugins ]]
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
