local set = vim.opt

vim.keymap.set("n", "<F3>", "<CMD>%!clang-format<CR>")
vim.keymap.set("v", "<F3>", ":!clang-format<CR><Esc>", { silent = true })

vim.keymap.set("i", "<C-CR>", "<Esc>>>lli<CR><Esc>O")
vim.keymap.set("n", "<C-CR>", ">>lli<CR><Esc>O")

-- Formating settings
    -- Width for autoindents
set.shiftwidth = 2
    -- Recognizes four spaces as a tab, so you can <BS> the whole indentation
set.softtabstop = 2
set.tabstop = 2
    -- Converts tabs to spaces
set.expandtab = true
    -- C indentation helper
set.smartindent = true
    -- Wraping lines.
set.wrap = true
