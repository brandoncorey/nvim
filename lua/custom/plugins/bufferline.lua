return {
  'akinsho/bufferline.nvim',
  config = function()
    require('bufferline').setup {
      options = {
        tab_size = 23, -- Increase to widen the buffer tabs
        themable = true,
        separator_style = 'thin',
        close_icon = '✘',
        buffer_close_icon = '✘',
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
          },
        },
        name_formatter = function(buf)
          local max_width = 23 -- tab size
          local space = ' ' -- Space between icon and name
          local name = buf.name
          local available_width = max_width - #space - 1 -- Subtract 1 for the space after the icon
          local truncated_name = #name > available_width
              and name:sub(1, available_width - 3) .. '...'
            or name
          return space .. truncated_name
        end,
      },
      highlights = {
        fill = {
          bg = 'NONE',
        },
      },
    }
  end,
}

