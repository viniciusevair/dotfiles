local ccc = require("ccc")
local mapping = ccc.mapping

ccc.setup({
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
})

vim.cmd [[hi CccFloatBorder guifg=#ffffff]]
