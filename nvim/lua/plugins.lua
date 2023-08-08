local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Colorschemes --
    {
        'savq/melange',
        lazy = false,
        priority = 1000,
    },
    { 'junegunn/seoul256.vim', event = "VeryLazy" },

    -- Plugins --

    -- Graphic plugins
    -- HUD
    { 'nvim-lualine/lualine.nvim' },
    {
        'nvim-tree/nvim-web-devicons',
        lazy=true,
        override = {
            zsh = {
                icon = "",
                name = "Zsh"
            }
        },
        color_icons = true,
        default = true,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
            routes = {
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
            },
        },

        dependencies = {
            "MunifTanjim/nui.nvim",
            { 
                "rcarriga/nvim-notify",
                keys = {
                    {
                        "<leader>u",
                        function()
                            require("notify").dismiss({ silent = true, pending = true })
                        end,
                        desc = "Dismiss all Notifications",
                    },
                },
            },
        },
    }, 
    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            char = "│",
            show_current_context = true,
            show_end_of_line = false,
            show_current_context_start = false,
            show_trailing_blankline_indent = false,
            use_treesitter = true,
            --filetype_exclude = {},
        },
    },
    {
        "rrethy/vim-hexokinase",
        build = "make",
        config = function ()
            vim.g['Hexokinase_virtualText'] = '◆'
        end,
    },
    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require("nvim-treesitter.configs").setup {
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter-context',
        event = "VeryLazy",
    },
    -- Colorpicker
    {
        'uga-rosa/ccc.nvim',

        opts = {
            highlighter = {
                auto_enable = false,
                lsp = true,
            },
            bar_char = "◆",
            point_char = "◈",
            win_opts = {
                relative = "cursor",
                row = 1,
                col = 1,
                style = "minimal",
                border = { "◈", "—", "◈", " ", "◈", "—", "◈", " ", },
            },
        }
    },

    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        version = "0.1.1",
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>f', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        end,
    },

    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            direction = "float",
            float_opts = {
                border = { "◈", "—", "◈", " ", "◈", "—", "◈", " ", },
            }
        }
    },

    -- LaTeX
    { 'lervag/vimtex', ft = "tex", },

    -- Formatting
    { 'prettier/vim-prettier', ft = {"html", "css", "js"} },
    { 'tpope/vim-surround' },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-repeat' },

    -- Git integration
    -- { 'tpope/vim-fugitive' },

    -- LSP dump
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        opts = {
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = ""
                },
                height = 0.75,
                border = { "◈", "—", "◈", " ", "◈", "—", "◈", " ", },
            },
        },
    },
    {'williamboman/mason-lspconfig.nvim'},
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
        }
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                version = "1.*",
                config = function()
                    require("luasnip").config.set_config {
                        history = true
                    }
                    local ls = require("luasnip")
                    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
                    vim.keymap.set({"i", "s"}, "<C-D>", function() ls.jump(-1) end, {silent = true})
                end,
            },
            {'saadparwaiz1/cmp_luasnip'}
        },
    },
    {'onsails/lspkind.nvim'},
}

require("lazy").setup(plugins)
