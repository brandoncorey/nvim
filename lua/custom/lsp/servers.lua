return {
    -- clangd = {},
    -- gopls = {},
    pyright = {},
    -- rust_analyzer = {},
    --
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

