local function bind_formatter()
  vim.keymap.set('n', '<leader>fm', function()
    vim.lsp.buf.format { async = false, timeout_ms = 10000 }
  end, { desc = '[F]ormat [M]anually' })
end

return {
  bind_formatter = bind_formatter,
}

