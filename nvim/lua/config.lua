-- Local alias so I can type less.
local set = vim.opt
-- Graphic settings
    -- Best theme u w u
vim.cmd.colorscheme('melange')
vim.cmd [[set background=dark]]
    -- Transparent Background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" } )
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" } )
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" } )
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff" } )
    -- Highlight current cursor position
set.cursorline = true
set.nu = true
set.rnu = true
    -- Changes current line highlight color.
--vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff" } )
    -- Highlight the 80th column for good coding visualization
set.colorcolumn = '80'
--vim.api.nvim_set_hl(0, "Colorcolumn", { bg = 23 } )
    -- Limits text to 80 column to enforce good coding visualization.
vim.cmd [[set textwidth=80]]
    -- Turn off lines and column highlights in case of window losing focus.
vim.cmd [[autocmd WinLeave * set colorcolumn=0]]
vim.cmd [[autocmd WinLeave * set nocursorline]]
    -- Turn on lines and column highlights when focus is recovered.
vim.cmd [[autocmd WinEnter * set colorcolumn=+0]]
vim.cmd [[autocmd WinEnter * set cursorline]]
    -- Turn on lines and column highlights when buffer is created.
vim.cmd [[autocmd BufEnter * set colorcolumn=+0]]
vim.cmd [[autocmd BufEnter * set cursorline]]
    -- New windows to appear below (horizontal split) or right (vertical split)
set.splitright = true
set.splitbelow = true
    -- Fix the perma highlight after search
set.hlsearch = false
    -- Show partial results as you type the search. (Cursor not really there)
set.incsearch = true
    -- Turn off showing mode on command line as lualine already shows it
vim.cmd [[set noshowmode]]
    -- Limit for bottomline
set.scrolloff = 5
    -- Sets nu+rnu, also moves signcolumn to the right of them.
vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : ''}%=%s"
    -- Makes signcolumn always visible, also sets them to only one column
vim.cmd [[set signcolumn=yes:1]]

--
-- Formating settings
    -- Width for autoindents
set.shiftwidth = 4
    -- Converts tabs to spaces
set.expandtab = true
    -- Recognizes four spaces as a tab, so you can <BS> the whole indentation
set.softtabstop = 4
    -- C indentation helper
set.smartindent = true
    -- Wraping lines.
set.wrap = true
    -- Bash-like completion.
vim.cmd [[set wildmode=longest,list]]
    -- Not in the mood for listchars rn, but I'll leave it here for later.
set.list = false
vim.opt.listchars:append "lead:⋅"

--
-- Turn off mouse visual selection
vim.cmd [[set mouse=]]

--
-- File encoding
vim.cmd [[set encoding=utf-8]]
vim.cmd [[set fileencoding=utf-8]]

--
-- Don't know exactly how to label these
set.virtualedit = "block"

--
-- Folding
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldlevel = 999

--
-- Filetype specifics
    -- HTML
vim.cmd [[autocmd FileType html setlocal ts=2 sts=2 sw=2]]
    -- JS
vim.cmd [[autocmd FileType javascript setlocal ts=2 sts=2 sw=2]]
    -- Neorg
vim.cmd [[autocmd FileType norg setlocal ts=2 sts=2 sw=2]]
