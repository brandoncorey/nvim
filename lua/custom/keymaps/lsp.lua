local function bind_lsp(auto_cmd_event)
  local client = vim.lsp.get_client_by_id(auto_cmd_event.data.client_id)
  vim.keymap.set(
    'n',
    'gr',
    require('telescope.builtin').lsp_references,
    { buffer = auto_cmd_event.buf, desc = 'LSP: [G]oto [R]eferences' }
  )
  vim.keymap.set(
    'n',
    'gI',
    require('telescope.builtin').lsp_implementations,
    { buffer = auto_cmd_event.buf, desc = 'LSP: [G]oto [I]mplementation' }
  )
  vim.keymap.set(
    'n',
    '<leader>D',
    require('telescope.builtin').lsp_type_definitions,
    { buffer = auto_cmd_event.buf, desc = 'LSP: Type [D]efinition' }
  )

  vim.keymap.set(
    'n',
    '<leader>ds',
    require('telescope.builtin').lsp_document_symbols,
    { buffer = auto_cmd_event.buf, desc = 'LSP: [D]ocument [S]ymbols' }
  )

  vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, {
    buffer = auto_cmd_event.buf,
    desc = 'LSP: [W]orkspace [S]ymbols',
  })

  --  Most Language Servers support renaming across files, etc.
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {
    buffer = auto_cmd_event.buf,
    desc = 'LSP: [R]e[n]ame',
  })

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
    buffer = auto_cmd_event.buf,
    desc = 'LSP: [C]ode [A]ction',
  })

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
    buffer = auto_cmd_event.buf,
    desc = 'LSP: [G]oto [D]eclaration',
  })

  --  To jump back, press <C-t>.
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
    buffer = auto_cmd_event.buf,
    desc = 'LSP: [G]oto [D]efinition',
  })

  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.keymap.set('n', '<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = auto_cmd_event.buf })
    end, { desc = '[T]oggle Inlay [H]ints' })
  end
end

return {
  bind_lsp = bind_lsp,
}

