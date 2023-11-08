-- "Legacy" stuff. Changed to NvimTree.

vim.g.netrw_banner=0        -- disable that anoying Netrw banner
vim.g.netrw_browse_split=4   -- open in a prior window
vim.g.netrw_altv=1            -- open splits to the right
vim.g.netrw_liststyle=3       -- treeview
vim.g.netrw_winsize=20
vim.g.netrw_bufsettings='noma nomod nonu nornu nobl nowrap ro signcolumn=no fillchars+=eob:\\  statuscolumn='

vim.api.nvim_exec([[
    let g:netrw_fastbrowse = 0
    autocmd FileType netrw setl bufhidden=wipe
    autocmd FileType netrw nnoremap <buffer> <leader>e ZQ
    function! CloseNetrw() abort
        for bufn in range(1, bufnr('$'))
            if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
                silent! execute 'bwipeout ' . bufn
                if getline(2) =~# '^" Netrw '
                    silent! bwipeout
                endif
                return
            endif
        endfor
    endfunction

    augroup closeOnOpen
        autocmd!
        autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), "&filetype") != "netrw"|call CloseNetrw()|endif
    aug END
]], false)
