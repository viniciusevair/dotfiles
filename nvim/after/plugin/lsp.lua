local lsp = require('lsp-zero').preset({})
local lspkind = require('lspkind')
local cmp = require('cmp')

lsp.extend_cmp()

lsp.configure('lua_ls', {
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

vim.diagnostic.config({
    virtual_text = false,
})
