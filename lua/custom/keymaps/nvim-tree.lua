local function bind_nvim_tree()
  vim.keymap.set(
    'n',
    '<leader>tt',
    ':NvimTreeToggle<CR>',
    { desc = '[T]oggle file [t]ree', noremap = true, silent = true }
  )
end

return {
  bind_nvim_tree = bind_nvim_tree,
}

