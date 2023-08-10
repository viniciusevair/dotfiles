-- vim:foldmethod=marker:foldlevel=0
-- Press <za> to open each folding individually, or <zr> to open all foldings

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
    -- {{{ Seoul256
    { "junegunn/seoul256.vim", event = "VeryLazy" },
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
                lualine_x = {'encoding', {'fileformat', symbols = {unix = '  ◈  ',}}, {'filetype', colored = false}},
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
        opts = {
            char = "│",
            show_current_context = true,
            show_end_of_line = false,
            show_current_context_start = false,
            show_trailing_blankline_indent = false,
            use_treesitter = true,
            --filetype_exclude = {},
        },
        config = function()
            -- Indent Blankline highlight colors.
            vim.api.nvim_set_hl(0, "IndentBlankLineContextChar", { fg = "#ebc06d", bg = "none" })
            --vim.api.nvim_set_hl(0, "IndentBlankLineChar", {fg = "#666666", bg = "none"})
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
                border = { "◈", "—", "◈", " ", "◈", "—", "◈", " " },
            },
        },
    },
    -- }}}

    -- Navigation
    -- {{{ Telescope
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.1",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>f", builtin.find_files, {})
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})
        end,
    },
    -- }}}
    -- {{{ Toggleterm
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            direction = "float",
            float_opts = {
                border = { "◈", "—", "◈", " ", "◈", "—", "◈", " " },
            },
        },
    },
    -- }}}

    -- LaTeX
    -- {{{ VimTeX
    {
        "lervag/vimtex",
        ft = "tex",
    },
    -- }}}

    -- Formatting
    -- {{{ Vim_Surround
    {
        "tpope/vim-surround",
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
                border = { "◈", "—", "◈", " ", "◈", "—", "◈", " " },
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
            {
                "L3MON4D3/LuaSnip",
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
                    require("luasnip.loaders.from_lua").lazy_load { paths = "~/.config/nvim/after/snippets/" }
                end,
            },
            { "saadparwaiz1/cmp_luasnip" },
        },
    },
    -- }}}
    -- {{{ LSPKind
    {
        "onsails/lspkind.nvim",
    },
    -- }}}
    -- {{{ Null_LS
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            null_ls.setup({
                sources = {
                    --null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.formatting.black,
                },
                -- you can reuse a shared lspconfig on_attach callback here
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
            })
        end,
    },
    -- }}}
    -- {{{ Vim_Prettier
    {
        "prettier/vim-prettier",
        ft = { "html", "css", "js" },
        config = function()
            -- Prettier config
            vim.g["prettier#quickfix_enabled"] = "0"
            vim.g["prettier#exec_cmd_async"] = "1"
            vim.g["prettier#config#single_quote"] = "true"
            vim.g["prettier#config#trailing_comma"] = "es5"
        end,
    },
    -- }}}
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

lsp.set_sign_icons({
    error = '│',
    warn  = '│',
    hint  = '│',
    info  = '│'
})

cmp.setup({
    window = {
        completion = cmp.config.window.bordered({
            border = { "◈", "—", "◈", " ", "◈", "—", "◈", " ", },
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        }),

        documentation = cmp.config.window.bordered({
            border = { "◈", "—", "◈", " ", "◈", "—", "◈", " ", },
        })
    },

    sources = {
        {name = "nvim_lsp", keyword_length = 2},
        {name = "luasnip", keyword_length = 2},
        {name = "path", keyword_length = 2},
        {name = "buffer", keyword_length = 6},
        {name = "nvim_lua", keyword_length = 2},
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

    sorting = {
        comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.locality,
        }
    },

    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping.confirm({select = true}),
    }
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
-- }}}
