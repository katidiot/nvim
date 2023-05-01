vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)

    use 'wbthomason/packer.nvim'

    use 'rust-lang/rust.vim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
    }

    use 'EdenEast/nightfox.nvim'
    use 'folke/tokyonight.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use 'savq/melange-nvim'
    use 'sainnhe/sonokai'

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use 'mbbill/undotree'

    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use 'williamboman/mason-lspconfig.nvim'
    use 'mfussenegger/nvim-dap'
    use 'onsails/lspkind.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            --{                                      -- Optional
            --'williamboman/mason.nvim',
            --run = function()
                --pcall(vim.cmd, 'MasonUpdate')
                --end,
                --},
                --{'williamboman/mason-lspconfig.nvim'}, -- Optional

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},     -- Required
                {'hrsh7th/cmp-nvim-lsp'}, -- Required
                {'L3MON4D3/LuaSnip'},     -- Required
            }
        }

        use {
            'windwp/nvim-autopairs',
            config = function() require("nvim-autopairs").setup {} end
        }

        use 'tpope/vim-surround'
        use 'tpope/vim-unimpaired'
        use 'tpope/vim-repeat'

        use 'nvim-tree/nvim-web-devicons'

        use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

        use 'simrat39/rust-tools.nvim'

    end)
