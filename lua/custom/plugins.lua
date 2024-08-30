local keymaps = require('custom.keymaps')

return {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

    {                 -- Adds git related signs to the gutter, as well as utilities for managing changes
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

    {                   -- Useful plugin to show you pending keybinds.
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
            { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
        },
        config = function()
            require('telescope').setup {
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
    { 'Bilal2453/luvit-meta',     lazy = true },
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
            { 'j-hui/fidget.nvim',       opts = {} },
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- Your LSP configuration here
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
            -- Your nvim-cmp configuration here
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

    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.pairs').setup()
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = vim.g.have_nerd_font }
            statusline.section_location = function()
                return '%2l:%-2v'
            end
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
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
        config = function()
            require('nvim-surround').setup {}
        end,
    },

    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup {
                git = {
                    ignore = false,
                },
                keymaps.bind_nvim_tree(),
            }
        end,
    },

    {
        'akinsho/bufferline.nvim',
        config = function()
            require('bufferline').setup {}
        end,
    },

    {
        'APZelos/blamer.nvim',
        config = function()
            vim.g.blamer_enabled = true
        end,
        lazy = false,
    },

    {
        'yetone/avante.nvim',
        event = 'VeryLazy',
        lazy = false,
        opts = {},
        keys = {
            {
                '<leader>aa',
                function()
                    require('avante.api').ask()
                end,
                desc = 'avante: ask',
                mode = { 'n', 'v' },
            },
            {
                '<leader>ar',
                function()
                    require('avante.api').refresh()
                end,
                desc = 'avante: refresh',
            },
            {
                '<leader>ae',
                function()
                    require('avante.api').edit()
                end,
                desc = 'avante: edit',
                mode = 'v',
            },
        },
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'zbirenbaum/copilot.lua',
            {
                'HakonHarnes/img-clip.nvim',
                event = 'VeryLazy',
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        use_absolute_path = true,
                    },
                },
            },
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { 'markdown', 'Avante' },
                },
                ft = { 'markdown', 'Avante' },
            },
        },
    },
}
