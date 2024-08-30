vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.api.nvim_set_keymap('n', '<leader>do', ':lua vim.diagnostic.open_float()<CR>', { desc = '[D]iagnostics [O]pen', noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dn', ':lua vim.diagnostic.goto_next()<CR>', { desc = '[D]iagnostics [N]ext', noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dp', ':lua vim.diagnostic.goto_prev()<CR>', { desc = '[D]iagnostics [P]revious', noremap = true, silent = true })

-- Terminal mode escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Insert mode navigation
vim.keymap.set('i', '<C-h>', '<left>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', '<down>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<up>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<right>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-e>', '<End>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-b>', '<Home>', { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set('n', '<leader>n', ':bnext<CR>', { desc = 'Move to next buffer' })
vim.keymap.set('n', '<leader>p', ':bprevious<CR>', { desc = 'Move to next previous' })
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = 'Close current buffer' })

-- Lsp
vim.keymap.set('n', '<leader>fm', function()
  vim.lsp.buf.format { async = false }
end, { desc = '[F]ormat [M]anually' })
