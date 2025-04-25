return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'javascript',
      'typescript',
      'python',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'sql',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },

    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}

