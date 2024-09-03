local servers = require 'custom.lsp.servers'
local formatters = require 'custom.lsp.formatters'
local linters = require 'custom.lsp.linters'

local function getCapabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  return capabilities
end

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
local ensure_installed_base = combine_keys(servers, formatters, linters)
local ensure_installed = ensure_installed_base or {}

vim.list_extend(ensure_installed, {
  --[[ additional can go here as table of strings --]]
})

return {
  capabilities = getCapabilities(),
  servers = servers,
  formatters = formatters,
  linters = linters,
  ensure_installed = ensure_installed,
}
