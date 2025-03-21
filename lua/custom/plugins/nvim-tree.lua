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
    require('custom.keymaps.nvim-tree').bind_nvim_tree()
  end,
}

