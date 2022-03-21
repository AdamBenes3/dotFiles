function _G.enter_or_list()
	local line = vim.api.nvim_buf_get_lines(0, vim.fn.line(".") - 1, -1, false)[1]:match(
					"^%s*%d*[%d%-—.)]+.?")
	if not line then
		return "\r"
	else
		local start, finish = line:find("[%d%-—.)]*%d")
		local main
		if not start or not finish then
			start, finish = line:find("[%-—.%)]+.?")
			return "\r" .. line:sub(start, finish)
		else
			main = line:sub(start, finish)
			local suffix = line:sub(finish + 1)
			return table.concat({
				"\r",
				main,
				vim.api.nvim_replace_termcodes("<Esc><C-a>a", true, true, true),
				suffix,
			})
		end
	end
end

function _G.enter_or_item()
	local line =
					vim.api.nvim_buf_get_lines(0, vim.fn.line(".") - 1, -1, false)[1]:match("^%s*\\item.?")
	if not line then
		return "\r"
	else
		return "\r\b\\item "
	end
end

vim.cmd [[
augroup _general_settings
	au!
	au FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
	au TextYankPost * lua require'vim.highlight'.on_yank{higroup = 'Search', timeout = 40}
augroup end

augroup _java
	au!
	au FileType java lua require('lsp.java-ls')
	au FileType java nnoremap ca <Cmd>lua require'jdtls'.code_action()<CR>
augroup end

augroup _tex
	au!
	au FileType tex inoremap <silent> <expr> <buffer> <Enter> v:lua.enter_or_item()
	au FileType tex inoremap <silent> <buffer> <M-c> \texttt{}<Left>
	au FileType tex inoremap <silent> <buffer> <S-Space> \,\,
augroup end

augroup _buffer_bindings
	au!
	au FileType lspinfo nnoremap <silent> <buffer> q :q<CR>
	au FileType text,markdown inoremap <silent> <expr> <buffer> <Enter> v:lua.enter_or_list()
	au FileType text,markdown inoremap <silent> <buffer> <M-d> <C-v>u2014
	au FileType tex,bib nnoremap <silent> <buffer> <M-D> <Cmd>!set x (compiler "%:p"); if not pgrep -f "zathura $x"; zathura "$x" &; end<CR>
	au FileType tex,bib inoremap <silent> <buffer> <M-D> <Cmd>!set x (compiler "%:p"); if not pgrep -f "zathura $x"; zathura "$x" &; end<CR>
	au FileType markdown nmap <M-r> <C-s><M-c>
	au FileType markdown imap <M-r> <C-s><M-c>
	au FileType tex,bib nmap <M-r> <C-s><M-D><CR>
	au FileType tex,bib imap <M-r> <C-s><M-D><CR>
augroup end

augroup _markdown
	au!
	au FileType markdown set et 

autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man setlocal ft=groff
autocmd BufRead,BufNewFile *.tex setlocal ft=tex tw=90
autocmd BufRead,BufNewFile *config,*.conf setlocal ft=config
autocmd BufRead,BufNewFile *fontconfig/* setlocal ft=xml
autocmd BufRead,BufNewFile */X11/xorg* setlocal ft=xf86conf
autocmd FileType text setlocal nonu signcolumn=no nocursorline nocursorcolumn tw=0
autocmd FileType i3config setlocal tw=0
autocmd BufRead,BufNewFile * cd %:h
]]
