local keymaps = require 'custom.keymaps'

return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup {
      git = {
        ignore = false,
      },
      view = {
        side = 'left',
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      }
    }
    keymaps.bind_nvim_tree()
  end,
}

