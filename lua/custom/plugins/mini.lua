return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.pairs').setup()
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
  end,
}

