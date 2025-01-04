-- vim:foldmethod=marker:foldlevel=0
-- Press <za> to open each folding individually, or <zR> to open all foldings

-- {{{ Lazy.nvim bootstrap
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
-- }}}

-- {{{ My border for all plugins.
local diamondBorder = { "◈", "—", "◈", " ", "◈", "—", "◈", " " }
-- Telescope has its own pattern, but its the same border.
local telescopeBorder = { "—", " ", "—", " ", "◈", "◈", "◈", "◈" }
-- }}}

-- {{{ Lazy Plugins Setup
require("lazy").setup({
    -- Colorschemes
    -- {{{ Melange
    {
        "savq/melange",
        lazy = false,
        priority = 1000,
    },
    -- }}}
    -- {{{ Possible Future Stuff
    { "junegunn/seoul256.vim", event = "VeryLazy" },
    { "baliestri/aura-theme", event = "VeryLazy" },
    { "sainnhe/everforest", event = "VeryLazy" },
    -- }}}

    -- HUD
    -- {{{ LuaLine
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = true,
                theme = 'gruvbox-material',
                component_separators = { left = '◈', right = '◈'},
                section_separators = { left = '', right = ''},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', {'fileformat', symbols = {unix = '',}}, {'filetype', colored = false}},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = {{
                    'buffers',
                    show_filename_only = true,   -- Shows shortened relative path when set to false.
                    hide_filename_extension = false,   -- Hide filename extension when set to true.
                    show_modified_status = true, -- Shows indicator when the buffer is modified.
                    mode = 0, 
                    -- 0: Shows buffer name
                    -- 1: Shows buffer index
                    -- 2: Shows buffer name + buffer index
                    -- 3: Shows buffer number
                    -- 4: Shows buffer name + buffer number
                    max_length = vim.o.columns * 6 / 7, -- Maximum width of buffers component,
                    -- it can also be a function that returns
                    -- the value of `max_length` dynamically.
                    filetype_names = {
                        TelescopePrompt = 'Telescope',
                        dashboard = 'Dashboard',
                        packer = 'Packer',
                        fzf = 'FZF',
                        alpha = 'Alpha'
                    },
                    symbols = {
                        modified = ' ●',
                        alternate_file = '# ',
                        directory =  '',
                    },
                }},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'tabs'}
            },
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        },
    },
    -- }}}
    -- {{{ Nvim_Devicons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {
            override = {
                zsh = {
                    icon = "",
                    name = "Zsh",
                },
            },
            color_icons = true,
            default = true,
        },
    },
    -- }}}
    -- {{{ Indent_Blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                --indent = {
                --    char = "│",
                --},

                scope = {
                    show_start = false,
                    show_end = false,
                    highlight = { "Function", "Label" },
                    --include = {
                    --    node_type = {
                    --        ["*"] = { "*" },
                    --    },
                    --},
                },

                exclude = { filetypes = { "txt" } },
            })
        end,
    },
    -- }}}
    -- {{{ Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = { "latex", "yang" },
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    -- }}}
    -- {{{ Treesitter_Context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = {
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            patterns = {
                -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                -- For all filetypes
                -- Note that setting an entry here replaces all other patterns for this entry.
                -- By setting the 'default' entry below, you can control which nodes you want to
                -- appear in the context window.
                default = {
                    "class",
                    "function",
                    "method",
                    "for",
                    "while",
                    "if",
                    "switch",
                    "case",
                    "interface",
                    "struct",
                    "enum",
                },
                -- Patterns for specific filetypes
                -- If a pattern is missing, *open a PR* so everyone can benefit.
                tex = {
                    "chapter",
                    "section",
                    "subsection",
                    "subsubsection",
                },
                haskell = {
                    "adt",
                },
                rust = {
                    "impl_item",
                },
                terraform = {
                    "block",
                    "object_elem",
                    "attribute",
                },
                scala = {
                    "object_definition",
                },
                vhdl = {
                    "process_statement",
                    "architecture_body",
                    "entity_declaration",
                },
                markdown = {
                    "section",
                },
                elixir = {
                    "anonymous_function",
                    "arguments",
                    "do_block",
                    "list",
                    "map",
                    "tuple",
                    "quoted_content",
                },
                json = {
                    "pair",
                },
                typescript = {
                    "export_statement",
                },
                yaml = {
                    "block_mapping_pair",
                },
            },
            exact_patterns = {
                -- Example for a specific filetype with Lua patterns
                -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                -- exactly match "impl_item" only)
                -- rust = true,
            },

            -- [!] The options below are exposed but shouldn't require your attention,
            --     you can safely ignore them.

            zindex = 20, -- The Z-index of the context window
            mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
        },
    },
    -- }}}

    -- Color stuff
    -- {{{ Vim_Hexokinase
    {
        "rrethy/vim-hexokinase",
        build = "make",
        config = function()
            vim.g["Hexokinase_virtualText"] = "◆"
        end,
    },
    -- }}}
    -- {{{ CCC (Colorpicker)
    {
        "uga-rosa/ccc.nvim",
        event = "VeryLazy",
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
                border = diamondBorder,
            },
        },
    },
    -- }}}

    -- Navigation
    -- {{{ Telescope
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            -- Helper function to find git root
            require('telescope.utils').get_git_root = function()
              local git_dir = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
              return git_dir and vim.fn.fnamemodify(git_dir, ":p") or nil
            end
            local t_builtin = require("telescope.builtin")
            local t_utils = require('telescope.utils')
            local t_actions = require('telescope.actions')
            -- Open telescope in current working directory
            vim.keymap.set("n", "<leader>fwd", function() t_builtin.find_files({ cwd = '$PWD' }) end, {})
            -- Open telescope in home directory
            vim.keymap.set("n", "<leader>ff", function() t_builtin.find_files({ cwd = '$HOME' }) end, {})
            -- Open telescope in current buffer file directory
            vim.keymap.set("n", "<leader>fwb", function() t_builtin.find_files({ cwd = t_utils.buffer_dir() }) end, {})
            -- Open telescope in a list of current open buffers
            vim.keymap.set("n", "<leader>fb", t_builtin.buffers, {})
            -- Open telescope in the jumplist history
            vim.keymap.set("n", "<leader>fj", t_builtin.jumplist, {})
            -- Open telescope in a list with all files from current git repository
            vim.keymap.set("n", "<leader>frf", t_builtin.git_files, {})
            -- Open telescope in grep mode for current working directory
            vim.keymap.set("n", "<leader>fg", t_builtin.live_grep, {})
            -- Open telescope in grep mode for all files from current git repository
            vim.keymap.set("n", "<leader>frg", function() t_builtin.live_grep({ cwd = t_utils.get_git_root() }) end, {})
            -- Open telescope in grep mode for all files from home
            vim.keymap.set("n", "<leader>fhg", function() t_builtin.live_grep({ cwd = '$HOME' }) end, {})
            -- Reopen last telescope window
            vim.keymap.set("n", "<leader>frr", t_builtin.resume, {})


            require("telescope").setup({
              defaults = {
                borderchars = {
                  preview = telescopeBorder,
                  prompt = telescopeBorder,
                  results = telescopeBorder,
                },
                mappings = {
                  i = {
                    ["<Tab>"] = t_actions.toggle_selection + t_actions.move_selection_worse,
                    ["<Ctrl-o>"] = t_actions.send_selected_to_qflist + t_actions.open_qflist,
                  },
                  n = {
                    ["<Tab>"] = t_actions.toggle_selection + t_actions.move_selection_worse,
                    ["<Ctrl-o>"] = t_actions.send_selected_to_qflist + t_actions.open_qflist,
                  },
                },
              }
            })
        end,
    },
    -- }}}
    -- {{{ Toggleterm
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            start_in_insert = true,
            persist_mode = false,
            direction = "float",
            float_opts = {
                border = diamondBorder,
            },
        },
    },
    -- }}}
    -- {{{ Nvim_Tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                actions = {
                    open_file = { quit_on_open = true }
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true
                },
                filters = {
                    custom = { '^.git$', '^node_modules$' }
                },
                git = {
                    enable = false
                },
                log = {
                    enable = true,
                    types = {
                        diagnostics = true
                    }
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = false,
                    debounce_delay = 50,
                    icons = {
                        hint = '│',
                        info = '│',
                        warning = '│',
                        error = '│'
                    }
                }
            })
        end,
    },
    --}}}
    -- {{{ Conform
    {
        'stevearc/conform.nvim',
        config = function ()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "black", "isort" },
                    -- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                    html = { { "prettierd", "prettier" } },
                    css = { { "prettierd", "prettier" } },
                    xml = { { "xmlformatter" } },
                    c = { { "clangd", "clang-format" } },
                },
            })

            vim.keymap.set("n", "<F3>", [[<Cmd>lua require("conform").format()<CR>]])
        end
    },
    -- }}}

    -- LaTeX
    -- {{{ VimTeX
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_quickfix_ignore_filters = {
                "Command terminated with space",
                "LaTeX Font Warning: Font shape",
                "Package caption Warning: The option",
                [[Underfull \\hbox (badness [0-9]*) in]],
                "Package enumitem Warning: Negative labelwidth",
                [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
                [[Package caption Warning: Unused \\captionsetup]],
                "Package typearea Warning: Bad type area settings!",
                [[Package fancyhdr Warning: \\headheight is too small]],
                [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
                "Package hyperref Warning: Token not allowed in a PDF string",
                [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
            }
            vim.g.vimtex_quickfix_mode=0
        end,
    },
    -- }}}

    -- Formatting
    -- {{{ Nvim_Surround
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    -- }}}
    -- {{{ Vim_Commentary
    {
        "tpope/vim-commentary",
    },
    -- }}}
    -- {{{ Vim_Repeat
    {
        "tpope/vim-repeat",
    },
    -- }}}
    -- {{{ Vim_Fugitive
    {
        "tpope/vim-fugitive",
        enabled = false,
    },
    -- }}}

    -- LSP dump
    -- {{{ Lsp_Zero
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = 'dev-v3',
        lazy = true,
    },
    -- }}}
    -- {{{ Mason
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = "",
                },
                height = 0.75,
                border = diamondBorder,
            },
        },
    },
    -- }}}
    -- {{{ Mason_LSPConfig
    {
        "williamboman/mason-lspconfig.nvim",
    },
    -- }}}
    -- {{{ Nvim_Lspconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
        },
    },
    -- }}}

    -- Autocompletion
    -- {{{ Nvim_CMP
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- {{{ LuaSnip
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
                config = function()
                    local ls = require("luasnip")
                    local s = ls.snippet
                    local sn = ls.snippet_node
                    local isn = ls.indent_snippet_node
                    local t = ls.text_node
                    local i = ls.insert_node
                    local f = ls.function_node
                    local c = ls.choice_node
                    local d = ls.dynamic_node
                    local r = ls.restore_node
                    local events = require("luasnip.util.events")
                    local ai = require("luasnip.nodes.absolute_indexer")
                    local extras = require("luasnip.extras")
                    local l = extras.lambda
                    local rep = extras.rep
                    local p = extras.partial
                    local m = extras.match
                    local n = extras.nonempty
                    local dl = extras.dynamic_lambda
                    local fmt = require("luasnip.extras.fmt").fmt
                    local fmta = require("luasnip.extras.fmt").fmta
                    local conds = require("luasnip.extras.expand_conditions")
                    local postfix = require("luasnip.extras.postfix").postfix
                    local types = require("luasnip.util.types")
                    local parse = require("luasnip.util.parser").parse_snippet
                    local ms = ls.multi_snippet
                    local k = require("luasnip.nodes.key_indexer").new_key

                    ls.config.setup({ enable_autosnippets = true })
                    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/after/snippets/" })
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/after/json_snippets/" })
                    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
                    vim.keymap.set({"i", "s"}, "<C-D>", function() ls.jump(-1) end, {silent = true})
                end,
            },
            -- }}}
            { "saadparwaiz1/cmp_luasnip" },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'rafamadriz/friendly-snippets' },
        },
    },
    -- }}}
    -- {{{ LSPKind
    {
        "onsails/lspkind.nvim",
    },
    -- }}}
    -- {{{ Vim_Prettier
    {
        "prettier/vim-prettier",
        ft = { "html", "css", "js", "xml" },
        config = function()
            -- Prettier config
            vim.g["prettier#quickfix_enabled"] = "0"
            vim.g["prettier#exec_cmd_async"] = "1"
            vim.g["prettier#config#single_quote"] = "true"
            vim.g["prettier#config#trailing_comma"] = "es5"
        end,
    },
    -- }}}
}, {
    ui = {
        border = diamondBorder,
    },
})
-- }}}

-- {{{ LSP Configuration
local lsp = require('lsp-zero').preset({})
local lspkind = require('lspkind')
local cmp = require('cmp')

lsp.extend_cmp()

require('lspconfig').lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

require('lspconfig').emmet_language_server.setup({
    filetypes = {
        "xml", "css", "eruby", "html", "javascript", "javascriptreact", "less",
        "sass", "scss", "pug", "typescriptreact"
    },
})

lsp.set_sign_icons({
    error = '│',
    warn  = '│',
    hint  = '│',
    info  = '│'
})

cmp.setup({
    window = {
        completion = cmp.config.window.bordered({
            border = diamondBorder,
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        }),

        documentation = cmp.config.window.bordered({
            border = diamondBorder,
        })
    },

    sources = {
        {name = "path", keyword_length = 2},
        {name = "nvim_lsp", keyword_length = 2},
        {name = "luasnip", keyword_length = 2},
        {name = "nvim_lua", keyword_length = 2},
        {name = "buffer", keyword_length = 3},
    },

    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
            maxwidth = 20,
            ellipsis_char = '...',

            before = function (entry, vim_item)
                local final = "()"
                vim_item.abbr = vim_item.abbr:match("[^(]+")
                vim_item.abbr = vim_item.abbr:gsub("%s+","")

                if vim_item.kind == "Function" or  vim_item.kind == "Method" then
                    vim_item.abbr = vim_item.abbr:gsub("%s+","") .. final
                end
                vim_item.menu = ""
                return vim_item
            end,
            mode = "symbol_text",
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })
        }),
    },

    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping.confirm({select = true}),
    }
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline('?', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {lsp.default_setup},
})

vim.diagnostic.config({
    virtual_text = false,
})
-- }}}
