local function getCapabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    return capabilities
end

local M = {}
M.capabilities = getCapabilities()

--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.

M.servers = {
    -- clangd = {},
    -- gopls = {},
    pyright = {},
    -- rust_analyzer = {},
    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`tsserver`) will work just fine
    tsserver = {},
    lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
            Lua = {
                completion = {
                    callSnippet = 'Replace',
                },
                -- You can toggle below to ignore Lua_LS"s noisy `missing-fields` warnings
                -- diagnostics = { disable = { "missing-fields" } },
            },
        },
    },
}

local formatters = {
    stylua = {},
    prettierd = {},
    black = {},
}

local linters = {
    eslint_d = {},
    ruff = {},
}

local function get_keys(tbl)
    local keys = {}
    for k in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

-- Function to combine keys from multiple tables
local function combine_keys(...)
    local combined_keys = {}
    for _, tbl in ipairs { ... } do
        local keys = get_keys(tbl)
        for _, key in ipairs(keys) do
            table.insert(combined_keys, key)
        end
    end
    return combined_keys
end

-- Combine keys from all tables into one list
local ensure_installed_base = combine_keys(M.servers, formatters, linters)

M.ensure_installed = ensure_installed_base or {}

vim.list_extend(M.ensure_installed, {
    --[[ additional can go here as table of strings --]]
})

return M
