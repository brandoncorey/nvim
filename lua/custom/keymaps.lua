--  nvim tree toggle
local function bind_nvim_tree()
    vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>',
        { desc = '[T]oggle file [t]ree', noremap = true, silent = true })
end
-- Manual format keybind
local function bind_formatter()
    vim.keymap.set('n', '<leader>fm', function()
        vim.lsp.buf.format { async = false }
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
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
        { buffer = auto_cmd_event.buf, desc = 'LSP: [G]oto [R]eferences' })
    vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
        { buffer = auto_cmd_event.buf, desc = 'LSP: [G]oto [I]mplementation' })
    vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions,
        { buffer = auto_cmd_event.buf, desc = 'LSP: Type [D]efinition' })

    vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
        { buffer = auto_cmd_event.buf, desc = 'LSP: [D]ocument [S]ymbols' })

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


    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.keymap.set('n', '<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = auto_cmd_event.buf })
            end, { desc = '[T]oggle Inlay [H]ints' })
    end
end

return {
    bind_nvim_tree = bind_nvim_tree,
    bind_formatter = bind_formatter,
    bind_fuzzy = bind_fuzzy,
    bind_lsp = bind_lsp,
}
