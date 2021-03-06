local function mapper(mode, _in, _out, opts, options)
	if opts then options = vim.tbl_extend("force", options, opts) end
	vim.api.nvim_set_keymap(mode, _in, _out, options)
end
function _G.nmap(mode, _in, _out, opts)
	mapper(mode, _in, _out, opts, {noremap = true, silent = true})
end
function _G.map(mode, _in, _out, opts)
	mapper(mode, _in, _out, opts, {noremap = false, silent = true})
end

function _G.automap(mode, filetype, _in, _out)
	vim.cmd(string.format("autocmd FileType %s %snoremap <buffer> <silent> %s %s", filetype, mode, _in,
	                      _out))
end

vim.g.mapleader = " "

-- Better indenting
nmap("n", "<C-S-lt>", "<<")
nmap("i", "<C-S-lt>", "<C-d>")
nmap("i", "<C-S-T>", "<C-d>")
nmap("n", "<C-S->>", ">>")
nmap("i", "<C-S->>", "<C-t>")

-- Clipboard management
nmap("n", "<C-x>", "dd")
nmap("x", "<C-x>", "d")
nmap("i", "<C-x>", "<C-o>dd")
nmap("n", "<C-c>", "Y")
nmap("x", "<C-c>", "y")
nmap("i", "<C-c>", "<C-o>Y")
nmap("n", "<C-v>", "p")
nmap("x", "<C-v>", "\"ddP")
nmap("i", "<C-v>", "<Esc>pa")
nmap("i", "<C-S-V>", "<Esc>Pa")
nmap("n", "f", "p")
nmap("n", "F", "P")

-- WordCount info
function _G.visualWC()
	local s = vim.fn.getpos("v")[2]
	local e = vim.fn.getcurpos()[2]
	if s > e then
		local x = s
		s = e
		e = x
	end
	local _, words = table.concat(vim.api.nvim_buf_get_lines(0, s - 1, e, false), " "):gsub("%S+", "")
	print("WordCount: " .. words)
end

nmap("x", "<M-i>", "<Cmd>lua visualWC()<CR>")

-- Text management
nmap("", "<C-s>", "<Cmd>w<CR>")
nmap("i", "<C-s>", "<Cmd>w<CR>")
nmap("n", "<M-S-Up>", "<Cmd>m-2<CR>")
nmap("i", "<M-S-Up>", "<Cmd>m-2<CR>")
nmap("n", "<M-S-Down>", "<Cmd>m+<CR>")
nmap("i", "<M-S-Down>", "<Cmd>m+<CR>")
nmap("n", "<C-S-Up>", "md\"dY\"dp`d")
nmap("i", "<C-S-Up>", "<Esc>md\"dY\"dp`da")
nmap("n", "<C-S-Down>", "md\"dY\"dP`d")
nmap("i", "<C-S-Down>", "<Esc>md\"dY\"dP`da")
nmap("n", "<C-a>", "<Esc>mdggVG")
nmap("i", "<C-a>", "<Esc>mdggi<C-o>VG")
nmap("n", "<C-S-A>", "<Esc>mdggVGy`da")
nmap("i", "<C-S-A>", "<Esc>mdggVGy`da")
nmap("i", "<C-S-U>", "<C-v>u")
nmap("i", "<C-BS>", "<C-W>")
nmap("i", "<S-Enter>", "<C-o>o")
nmap("i", "<C-Enter>", "<C-o>O")
nmap("i", "<M-Enter>", "<Esc>mdO<Esc>`da")
nmap("i", "<M-S-Enter>", "<Esc>mdo<Esc>`da")
nmap("n", "<M-a>", "<C-a>") -- increase value
nmap("i", "<M-a>", "<C-o><C-a>") -- increase value
nmap("n", "<M-A>", "<C-x>") -- decrease value
nmap("i", "<M-A>", "<C-o><C-x>") -- decrease value
nmap("n", "C", "vg~") -- toggle text case; gu for lowercase, gU for UPPERCASE
nmap("x", "C", "g~")

-- Deleting text
nmap("n", "<C-S-D>", "\"_diW")
nmap("i", "<C-S-D>", "<C-o>\"_diW")
nmap("n", "<C-d>", "\"_dd")
nmap("i", "<C-d>", "<C-o>\"_dd")
nmap("i", "<C-S-Del>", "<C-o>\"_de")
nmap("", "<Del>", "\"_x")

-- Undotree
nmap("n", "r", "<Cmd>redo<CR>")
nmap("", "<C-z>", "<Cmd>undo<CR>")
nmap("i", "<C-z>", "<Cmd>undo<CR>")
nmap("", "<C-y>", "<Cmd>redo<CR>")
nmap("i", "<C-y>", "<Cmd>redo<CR>")

-- Moving around
nmap("", "K", "{")
nmap("i", "<M-K>", "<C-o>{")
nmap("", "J", "}")
nmap("i", "<M-J>", "<C-o>}")
nmap("", "<C-h>", "<C-Left>")
nmap("i", "<C-h>", "<C-Left>")
nmap("", "<C-j>", "<PageDown>")
nmap("i", "<C-j>", "<PageDown>")
nmap("", "<C-k>", "<PageUp>")
nmap("i", "<C-k>", "<PageUp>")
nmap("", "<C-l>", "<C-Right>")
nmap("i", "<C-l>", "<C-Right>")
nmap("", "<M-S-H>", "<Home>")
nmap("i", "<M-S-H>", "<Home>")
nmap("", "<M-S-J>", "L")
nmap("i", "<M-S-J>", "<C-o>L")
nmap("", "<M-S-K>", "H")
nmap("i", "<M-S-K>", "<C-o>H")
nmap("", "<M-S-L>", "<End>")
nmap("i", "<M-S-L>", "<End>")
nmap("i", "<M-h>", "<Left>")
nmap("i", "<M-j>", "<Down>")
nmap("i", "<M-k>", "<Up>")
nmap("i", "<M-l>", "<Right>")
-- With arrows
nmap("", "<C-Up>", "<PageUp>")
nmap("", "<S-Up>", "K")
nmap("i", "<C-Up>", "<PageUp>")
nmap("", "<C-Down>", "<PageDown>")
nmap("", "<S-Down>", "J")
nmap("i", "<C-Down>", "<PageDown>")
nmap("i", "<S-Left>", "<Left><C-o>v")
nmap("i", "<S-Down>", "<C-o>v<Down>")
nmap("i", "<S-Up>", "<C-o>v<Up>")
nmap("i", "<S-Right>", "<C-o>v")
nmap("i", "<S-Home>", "<Left><C-o>v^")
nmap("i", "<S-End>", "<C-o>v$")

-- Closing
nmap("", "<C-q>", "<Cmd>q<CR>")
nmap("i", "<C-q>", "<Cmd>q<CR>")
nmap("", "<C-S-Q>", "<Cmd>q!<CR>")
nmap("i", "<C-S-Q>", "<Cmd>q!<CR>")
nmap("t", "<C-Esc>", "<C-\\><C-n>")

-- Tab management through nvim, Buffers in barbar-s.lua
nmap("", "<C-t>", "<Cmd>tabnew %<CR>")
nmap("", "<C-Tab>", "<Cmd>tabnext<CR>")
nmap("", "<M-C-Tab>", "<Cmd>tabprevious<CR>")
nmap("", "<C-.>", "<Cmd>tabnext<CR>")
nmap("i", "<C-.>", "<Cmd>tabnext<CR>")
nmap("", "<C-,>", "<Cmd>tabprevious<CR>")
nmap("i", "<C-,>", "<Cmd>tabprevious<CR>")
nmap("", "<M-C-w>", "<Cmd>tabclose<CR>")
nmap("i", "<M-C-w>", "<Cmd>tabclose<CR>")
nmap("", "<C-1>", "<Cmd>tabnext 1<CR>")
nmap("i", "<C-1>", "<Cmd>tabnext 1<CR>")
nmap("", "<C-2>", "<Cmd>tabnext 2<CR>")
nmap("i", "<C-2>", "<Cmd>tabnext 2<CR>")
nmap("", "<C-3>", "<Cmd>tabnext 3<CR>")
nmap("i", "<C-3>", "<Cmd>tabnext 3<CR>")
nmap("", "<C-4>", "<Cmd>tabnext 4<CR>")
nmap("i", "<C-4>", "<Cmd>tabnext 4<CR>")
nmap("", "<C-5>", "<Cmd>tabnext 5<CR>")
nmap("i", "<C-5>", "<Cmd>tabnext 5<CR>")
nmap("", "<C-6>", "<Cmd>tabnext 6<CR>")
nmap("i", "<C-6>", "<Cmd>tabnext 6<CR>")
nmap("", "<C-7>", "<Cmd>tabnext 7<CR>")
nmap("i", "<C-7>", "<Cmd>tabnext 7<CR>")
nmap("", "<C-8>", "<Cmd>tabnext 8<CR>")
nmap("i", "<C-8>", "<Cmd>tabnext 8<CR>")
nmap("", "<C-9>", "<Cmd>tabnext 9<CR>")
nmap("i", "<C-9>", "<Cmd>tabnext 9<CR>")

-- Switching splits
nmap("n", "<Leader>v", "<Cmd>split<CR>")
nmap("n", "<Leader>h", "<Cmd>vsplit<CR>")
nmap("n", "<C-S-H>", "<C-w>h")
nmap("i", "<C-S-H>", "<C-o><C-w>h")
-- <C-S-J> shows as <C-S-K> and <C-S-K> as <S-NL>
nmap("n", "<C-S-K>", "<C-w>j")
nmap("i", "<C-S-K>", "<C-o><C-w>j")
nmap("n", "<S-NL>", "<C-w>k")
nmap("i", "<S-NL>", "<C-o><C-w>k")
nmap("n", "<C-S-L>", "<C-w>l")
nmap("i", "<C-S-L>", "<C-o><C-w>l")

-- Resize windows
nmap("n", "<M-j>", "<Cmd>resize -2<CR>")
nmap("n", "<M-k>", "<Cmd>resize +2<CR>")
nmap("n", "<M-h>", "<Cmd>vertical resize -2<CR>")
nmap("n", "<M-l>", "<Cmd>vertical resize +2<CR>")

nmap("n", "S", "<Cmd>term<CR><Cmd>setlocal nonu<CR>i")
nmap("n", "<Leader>d", "<Cmd>cd %:h<CR>")

-- Refresh and reload
nmap("n", "<F5>", "<Cmd>e<CR>")
nmap("n", "<F17>", "<Cmd>e!<CR>")
nmap("n", "<Leader>l", "<Cmd>luafile %<CR>")
nmap("n", "<Leader>/", "<Cmd>noh<CR>") -- clears all highlights/searches

-- Compiling
local mdC = "<Cmd>!firefox --new-tab (compiler \"%:p\") & && i3 [class=\"firefox\"] focus<CR>"
automap("n", "markdown", "<M-c>", mdC .. "<CR>")
automap("i", "markdown", "<M-c>", mdC .. "<CR>")
