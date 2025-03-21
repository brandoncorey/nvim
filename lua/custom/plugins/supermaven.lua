return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = require('custom.keymaps.supermaven').bind_super_maven(),
    }
  end,
}

