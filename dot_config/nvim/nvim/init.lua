--     ____  __
--    |    |/ _|____    ____ _______________
--    |      < \__  \ _/ __ \\___   /\_  __ \
--    |    |  \ / __ \\  ___/ /    /  |  | \/
--    |____|__ (____  /\___  >_____ \ |__|
--        \/    \/     \/      \/
--
--    Courtesy of kickstart.nvim !!!

-- [[ Setting options ]]
require 'config.options'

-- [[ Basic and high powered keybinds ]]
require 'config.keybinds'

-- [[ Auto commands ]]
require 'config.autocmd'

-- [[ Bootstrap Lazy package manager and install plugins ]]
require 'config.lazy'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
