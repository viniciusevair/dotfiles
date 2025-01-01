-- Currently a mess. Gotta organize it better when I get the time.

-- Set space key as leader key.
vim.keymap.set("n", "<Space>", "<NOP>")
vim.g.mapleader = " "

-- Set \ key as local leader key.
vim.cmd [[let maplocalleader = '\']]

-- Explorer.
vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle $PWD<CR>")
vim.keymap.set("n", "<leader>feb", "<Cmd>NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader>feh", "<Cmd>NvimTreeToggle ~/.<CR>")
-- Open this file.
vim.keymap.set("n", "ø", "<Cmd>NvimTreeToggle ~/.config/nvim/lua<CR>", { silent = true })
vim.keymap.set("n", "þ", "<Cmd>NvimTreeToggle ~/.config/nvim/after/snippets<CR>", { silent = true })

-- Plugin manager
vim.keymap.set("n", "<C-l>", "<Cmd>Lazy<CR>", { silent = true })

-- Buffers.
-- Move between buffers.
vim.keymap.set("n", "<A-1>", "<Cmd>b1<CR>", { silent = true })
vim.keymap.set("n", "<leader>j", "<Cmd>bprev<CR>", { silent = true })
vim.keymap.set("n", "<leader>k", "<Cmd>bnext<CR>", { silent = true })
vim.keymap.set("n", "<A-\'>", "<Cmd>bprev<CR>", { silent = true })
vim.keymap.set("n", "<A-2>", "<Cmd>bnext<CR>", { silent = true })
vim.keymap.set("i", "<A-2>", "<Esc><Cmd>bnext<CR>", { silent = true })
-- Delete current buffer.
vim.keymap.set("n", "<leader>z", "<Cmd>bd<CR>", { silent = true })
-- Write to current file.
vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>")

-- Move to line edges
vim.keymap.set("i", "<A-l>", "<Esc>A")
vim.keymap.set({ "n", "v" }, "<A-l>", "$")
vim.keymap.set("i", "<A-h>", "<Esc>I")
vim.keymap.set({ "n", "v" }, "<A-h>", "^")

-- Move to end of previous word
vim.keymap.set({ "n", "v" }, "<A-e>", "ge")
vim.keymap.set({ "n", "v" }, "<A-E>", "gE")

-- Move to start/end of last visual selection
vim.keymap.set("n", "<C-,>", "`<")
vim.keymap.set("n", "<C-.>", "`>")
vim.keymap.set("v", "<C-,>", "<Esc>`<")
vim.keymap.set("v", "<C-.>", "<Esc>`>")
vim.keymap.set("n", "<C-;>", "`^")

-- Move to function start/end
vim.keymap.set({ "n", "v" }, "<A-k>", "?^[^ \\t#/-]<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "<A-j>", "/^[^ \\t#/-]<CR>", { silent = true })

-- Move to the corresponding bracket
vim.keymap.set({ "n", "v" }, "<A-m>", "%")

-- Move lines up and down when in visual mode (needs better shortcut).
vim.keymap.set("x", "L", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("x", "H", ":m '<-2<CR>gv=gv", { silent = true })

-- Center the cursor after halfpage jumps.
vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz")

-- Register management.
-- Substitute text without writing deleted text to the register.
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Delete without writing to the register.
vim.keymap.set({ "n", "x" }, "<leader>d", [["_d]])

-- Black magic stuff.
-- Replace all occurrences of a word in the file.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]])
-- Replace all occurrences of a word in the line.
vim.keymap.set({ "n", "v" }, "ß", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
-- Change spacing between parenthesis. "a" to add space, "b" to remove.
vim.keymap.set("n", "<leader>as", [[mz<Cmd>%s/\(\a\)(/\1 (/gc<CR>`z]])
vim.keymap.set("n", "<leader>bs", [[mz<Cmd>%s/\(\a\) (/\1(/gc<CR>`z]])
vim.keymap.set("v", "<leader>as", [[mz<Cmd>s/\(\a\)(/\1 (/gc<CR>`z]])
vim.keymap.set("v", "<leader>bs", [[mz<Cmd>s/\(\a\) (/\1(/gc<CR>`z]])
-- Change between snake and camel case. "a" for snake, "b" for camel.
vim.keymap.set("n", "<leader>ac", [[mz<Cmd>%s/\(\l\)_\(\l\)/\1\U\2/gc<CR>`z]])
vim.keymap.set("n", "<leader>bc", [[mz<Cmd>%s/\(\l\)\(\u\)/\1_\l\2/gc<CR>`z]])
vim.keymap.set("v", "<leader>ac", [[mz<Cmd>s/\(\l\)_\(\l\)/\1\U\2/gc<CR>`z]])
vim.keymap.set("v", "<leader>bc", [[mz<Cmd>s/\(\l\)\(\u\)/\1_\l\2/gc<CR>`z]])

-- Writing.
-- C pointer arrows.
vim.keymap.set({ "i", "t" }, "<C-a>", "->")
-- Capitalize word
vim.keymap.set("i", "<C-c>", "<Esc>mCbg~l`Ca")
-- Cut/Delete text till parenthesis
vim.keymap.set("n", "©", "ct)")
vim.keymap.set("n", "ð", "dt)")
-- Cut text till underscore
vim.keymap.set("n", "<leader>c", "ct_")
-- Colorpicker shortcut
vim.keymap.set("n", "<C-c>", "<Cmd>CccPick<CR>", { silent = true })
--vim.keymap.set("i", "<C-c>", "<Esc>l<Cmd>CccPick<CR>", { silent = true })
-- <CR> tags helper.
vim.keymap.set("i", "<C-CR>", "<CR><Esc>O")
vim.keymap.set("n", "<C-CR>", "i<CR><Esc>O")
-- More sane cut/delete word shortcut
vim.keymap.set("n", "cw", "ciw")
vim.keymap.set("n", "dw", "daw")
vim.keymap.set("n", "cW", "ciW")
vim.keymap.set("n", "dW", "daW")
-- Duplicate current line
vim.keymap.set("n", "yp", "yyp")
-- Duplicate current visual selection
vim.keymap.set("v", "<leader>lp", "y`>p")

-- Formatting.
-- Fix indentation inside a function.
vim.keymap.set("n", "§", "mzgg=G`zzz")
-- Remove the space before current word.
vim.keymap.set("n", "æ", "mzEBhx`zh")
-- Merge whole paragraph onto only one line
vim.keymap.set("n", "<C-j>", "vipJ<Esc>")

-- Yank to normal register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n" }, "<leader>ya", "<CMD>%y+<CR>")

-- Yank the whole file
vim.keymap.set({ "n" }, "yaa", "<CMD>%y<CR>")

-- Folding remaps
vim.keymap.set("n", "zr", "zR")
vim.keymap.set("n", "zR", "zr")
vim.keymap.set("n", "zm", "zM")
vim.keymap.set("n", "zM", "zm")

-- Make J and K part of jumplist
vim.keymap.set({ "n", "x" }, "j", [[v:count ? (v:count >=2 ? "m'" . v:count : "") . "j" : "j"]], { expr = true })
vim.keymap.set({ "n", "x" }, "k", [[v:count ? (v:count >= 2 ? "m'" . v:count : "") . "k" : "k"]], { expr = true })

-- Terminal inside nvim shortcut
vim.keymap.set("n", "<C-t>", "<Cmd>ToggleTerm<CR>", { silent = true })
vim.keymap.set("t", "<C-t>", [[<C-\><C-n><Cmd>ToggleTerm<CR>]], { silent = true })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

-- Run the code from current buffer. Uses my "Run" function found at zsh
-- directory. In terminal mode runs the code from the "background" buffer.
vim.keymap.set("i", "<F12>", "<Esc><Cmd>w<CR><Cmd>TermExec cmd='Run %'<CR>")
vim.keymap.set("n", "<F12>", "<Cmd>w<CR><Cmd>TermExec cmd='Run %'<CR>")
vim.keymap.set("t", "<F12>", [[<C-\><C-n><Cmd>ToggleTerm<CR><Cmd>TermExec cmd='Run %'<CR>]])

-- temp
vim.keymap.set("i", "<C-z>", "struct graph_t*")
vim.keymap.set("i", "<C-x>", "struct set_t*")
