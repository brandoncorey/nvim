local keymaps = require 'custom.keymaps'

return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = keymaps.bind_super_maven(),
    }
  end,
}

