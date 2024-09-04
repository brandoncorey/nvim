--  nvim tree toggle
local function bind_nvim_tree()
  vim.keymap.set(
    'n',
    '<leader>tt',
    ':NvimTreeToggle<CR>',
    { desc = '[T]oggle file [t]ree', noremap = true, silent = true }
  )
end
-- Manual format keybind
local function bind_formatter()
  vim.keymap.set('n', '<leader>fm', function()
    vim.lsp.buf.format { async = false, timeout_ms = 5000 }
  end, { desc = '[F]ormat [M]anually' })
end

-- keybinds for fuzzy finder
local function bind_fuzzy()
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
  vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]earch [R]ecent Files' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind open [B]uffers' })
  vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = 'Search in current buffer' })
  vim.keymap.set('n', '<leader>sb', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch in open [B]uffers' })
  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

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

function bind_nvim_cmp()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  return cmp.mapping.preset.insert {
    -- Select the [n]ext item
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Select the [p]revious item
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    -- Scroll the documentation window [b]ack / [f]orward
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- Accept ([y]es) the completion.
    --  This will auto-import if your LSP supports it.
    --  This will expand snippets if the LSP sent a snippet.
    ['<CR>'] = cmp.mapping.confirm { select = true },

    -- If you prefer more traditional completion keymaps,
    -- you can uncomment the following lines
    --['<CR>'] = cmp.mapping.confirm { select = true },
    --['<Tab>'] = cmp.mapping.select_next_item(),
    --['<S-Tab>'] = cmp.mapping.select_prev_item(),

    -- Manually trigger a completion from nvim-cmp.
    --  Generally you don't need this, because nvim-cmp will display
    --  completions whenever it has completion options available.
    ['<C-Space>'] = cmp.mapping.complete {},

    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  }
end

return {
  bind_nvim_tree = bind_nvim_tree,
  bind_formatter = bind_formatter,
  bind_fuzzy = bind_fuzzy,
  bind_lsp = bind_lsp,
  bind_nvim_cmp = bind_nvim_cmp,
}
