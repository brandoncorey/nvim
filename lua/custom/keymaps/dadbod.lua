local function bind_dadbod()
  vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<CR>', { desc = 'Toggle [D]ad[B]od UI' })
  
  vim.keymap.set('n', '<leader>df', '<cmd>DBUIFindBuffer<CR>', { desc = '[D]adbod [F]ind Buffer' })
  
  vim.keymap.set('n', '<leader>da', '<cmd>DBUIAddConnection<CR>', { desc = '[D]adbod [A]dd Connection' })
  
  vim.keymap.set('n', '<leader>dt', '<cmd>DBUIToggleDetails<CR>', { desc = '[D]adbod [T]oggle Details' })
  
  vim.keymap.set('n', '<leader>ds', '<cmd>DBUILastQueryInfo<CR>', { desc = '[D]adbod [S]ave Query' })
end

return {
  bind_dadbod = bind_dadbod,
}

