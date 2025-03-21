local keymaps = require 'custom.keymaps'

return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to "VimEnter"
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              preview_width = 0.55, -- Makes the preview window 70% of the total width
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      keymaps.bind_fuzzy()
    end,
  },

  -- LSP Plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      {
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
          'williamboman/mason.nvim',
          'nvimtools/none-ls.nvim',
        },
      },
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require 'custom.mason'
      keymaps.bind_formatter()
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = keymaps.bind_nvim_cmp(),

        sources = {
          {
            name = 'lazydev',
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'supermaven' },
        },
      }
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.pairs').setup()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
    end,
  },

  {
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
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {
        git = {
          ignore = false,
        },
        view = {
          side = 'left',
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
      }
      keymaps.bind_nvim_tree()
    end,
  },

  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup {
        options = {
          tab_size = 23, -- Increase to widen the buffer tabs
          themable = true,
          separator_style = 'thin',
          close_icon = '✘',
          buffer_close_icon = '✘',
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
            },
          },
          name_formatter = function(buf)
            local max_width = 23 -- tab size
            local space = ' ' -- Space between icon and name
            local name = buf.name
            local available_width = max_width - #space - 1 -- Subtract 1 for the space after the icon
            local truncated_name = #name > available_width
                and name:sub(1, available_width - 3) .. '...'
              or name
            return space .. truncated_name
          end,
        },
        highlights = {
          fill = {
            bg = 'NONE',
          },
        },
      }
    end,
  },

  {
    'APZelos/blamer.nvim',
    config = function()
      vim.g.blamer_enabled = true
      vim.g.blamer_show_in_insert_modes = false
    end,
    lazy = false,
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = keymaps.bind_super_maven(),
      }
    end,
  },

  {
    -- Make sure to set this up properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { 'markdown', 'Avante' },
    },
    ft = { 'markdown', 'Avante' },
  },

  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = 'copilot',
      copilot = {
        model = 'o3-mini',
      },
      vendors = {
        copilot_gemini_flash = {
            __inherited_from = 'copilot',
            model = 'gemini-2.0-flash-001',
          },
        copilot_claude_sonnet = {
            __inherited_from = 'copilot',
            model = 'claude-3.7-sonnet',
          },
      },
      -- gemini = {
      --   model = 'gemini-2.0-flash', -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      --   temperature = 0,
      --   max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      -- },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- Available
          behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            support_paste_from_clipboard = false,
            minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = true, -- Whether to enable token counting. Default to true.
            enable_cursor_planning_mode = false,
          },
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },
}
