return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
    'DBUIToggleDetails',
    'DBUILastQueryInfo',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    
    -- UI configuration
    vim.g.db_ui_auto_execute_table_helpers = 1
    
    vim.g.db_ui_result_layout = {
      window = {
        height = 30,  -- Make the result window taller (default is 10)
      },
    }
    
    -- Setup keymaps
    require('custom.keymaps.dadbod').bind_dadbod()
  end,
}
