local lspconfig = require("core.lspconfig")

require('mason').setup()

require('mason-tool-installer').setup {
    ensure_installed = lspconfig.ensure_installed,
    auto_update = false,
    run_on_start = true,
}

require('mason-lspconfig').setup {
    automatic_installation = true,
    handlers = {
        function(server_name)
            local server = lspconfig.servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, lspconfig.capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
}

require('mason-null-ls').setup {
    ensure_installed = lspconfig.ensure_installed,
    automatic_installation = true,
    handlers = {},
}

require('null-ls').setup {
    sources = {}, -- anything not supported by mason-null-ls
}
