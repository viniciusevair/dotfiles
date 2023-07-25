vim.cmd [[packadd packer.nvim]] -- packadd packer module

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- this is essential.

    -- Colorschemes --
    use 'savq/melange'
    use 'junegunn/seoul256.vim'

    -- Plugins --

    -- Graphic plugins
    -- HUD
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        "rrethy/vim-hexokinase",
        run = "make",
    }
    -- Treesitter
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use 'nvim-treesitter/nvim-treesitter-context'
    -- Colorpicker
    use 'uga-rosa/ccc.nvim'

    -- Navigation
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {"akinsho/toggleterm.nvim", tag = '*'}

    -- Language Server Provider
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'onsails/lspkind.nvim'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            -- Snippets
            {'L3MON4D3/LuaSnip'},
        }
    }

    -- LaTeX
    use 'lervag/vimtex'

    -- Formatting
    use 'prettier/vim-prettier'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'

    -- Git integration
    use 'tpope/vim-fugitive'
end)
