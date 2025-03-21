local nvim_tree = require('custom.keymaps.nvim-tree')
local formatter = require('custom.keymaps.formatter')
local fuzzy = require('custom.keymaps.fuzzy')
local lsp = require('custom.keymaps.lsp')
local cmp = require('custom.keymaps.cmp')
local super_maven = require('custom.keymaps.supermaven')

return {
  bind_nvim_tree = nvim_tree.bind_nvim_tree,
  bind_formatter = formatter.bind_formatter,
  bind_fuzzy = fuzzy.bind_fuzzy,
  bind_lsp = lsp.bind_lsp,
  bind_nvim_cmp = cmp.bind_nvim_cmp,
  bind_super_maven = super_maven.bind_super_maven,
}
