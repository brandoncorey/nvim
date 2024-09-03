local lsp = require 'core.lspconfig'

require('mason').setup()

require('mason-tool-installer').setup {
  ensure_installed = lsp.ensure_installed,
  auto_update = true,
  run_on_start = true,
}

require('mason-lspconfig').setup {
  automatic_installation = true,
  handlers = {
    function(server_name)
      local server = lsp.servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend('force', {}, lsp.capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

local function has_eslint_config()
  local eslint_files = { '.eslintrc.json', '.eslintrc.js', '.eslintrc' }
  local root_dir = vim.fn.finddir('node_modules/..', vim.fn.getcwd() .. ';')

  for _, file in ipairs(eslint_files) do
    if vim.fn.filereadable(root_dir .. '/' .. file) == 1 then
      return true
    end
  end
  return false
end

local builtin_prettier_eslint = require 'custom.lsp.builtins.prettier-eslint'

local null_ls = require 'null-ls'
null_ls.setup {
  sources = {},
}

require('mason-null-ls').setup {
  ensure_installed = lsp.ensure_installed,
  automatic_installation = false,
  handlers = { -- swapping in custom prettier based on presence of eslint
    prettierd = function()
      if has_eslint_config() then
        null_ls.register(builtin_prettier_eslint)
      else
        null_ls.register(null_ls.builtins.formatting.prettierd)
      end
    end,
  },
}
