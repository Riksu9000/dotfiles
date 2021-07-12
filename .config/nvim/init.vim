set backspace=start,indent
set clipboard=unnamedplus
set cursorline
set lazyredraw
set list
set listchars+=tab:\⎢\ ,trail:~,extends:>,precedes:<
set mouse=a
set noswapfile
set number relativenumber
set shiftwidth=4
set splitright
set splitbelow
set tabstop=4
set notermguicolors
set wildmode=longest:full,full
set wildmenu
:vertical ball

" Required for statusline colors?
syntax on

let mapleader=' '

let g:netrw_browsex_viewer="$BROWSER"

" Fix some keys on finnish keyboard layout
map ¤ $
map Ö :
map & ^

"Conflicts with vim-gitgutter
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :call ToggleOverLength()<CR>
nnoremap <Leader>O :!open %<CR>
" Set width to min 50% max 80 somehow?
nnoremap <Leader>n :vsp ~/docs/notes<CR>
nnoremap <Leader>g :packadd goyo.vim<CR>:Goyo<CR>
nnoremap <Leader>f :Files<CR>

command Sudowrite execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
command Cdhere cd %:p:h
command Fix execute 'lua vim.lsp.buf.code_action()'

"https://vim.fandom.com/wiki/Super_retab
:command! -range=% Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
:command! -range=% Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

silent! colorscheme mynoctu

" Highlight text over 100 columns
highlight OverLength ctermfg=3
let s:overlen=1 " TODO: can the current status be read instead of a variable?
function ToggleOverLength()
	if s:overlen
		highlight OverLength ctermfg=none
		let s:overlen=0
	else
		highlight OverLength ctermfg=3
		let s:overlen=1
	endif
endfunction
match OverLength /\%101v.\+/

" Statusline left
set statusline+=%1*\ %<%f\ %m%r
" Middle
set statusline+=%0*%=
" Right
set statusline+=%{&fileformat}\ %{&fileencoding}\ %{&filetype}\ %1*%5.(%p%%%)\ %1*\ %3.l:%-3v
" Statusline colors
hi User1 ctermbg=0

let g:goyo_height="100%"

"autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

lua require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" vim-gitgutter options
set updatetime=100

if $TERM == "linux"
	set notermguicolors
	colorscheme default
endif
