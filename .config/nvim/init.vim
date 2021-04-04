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
set termguicolors
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
nnoremap <Leader>s :SyntasticToggleMode<CR>
nnoremap <Leader>o :call ToggleOverLength()<CR>
nnoremap <Leader>O :!open %<CR>
" Set width to min 50% max 80 somehow?
nnoremap <Leader>n :vsp ~/docs/notes<CR>
nnoremap <Leader>g :packadd goyo.vim<CR>:Goyo<CR>

command Sudowrite execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

command Cdhere cd %:p:h

"https://vim.fandom.com/wiki/Super_retab
:command! -range=% Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
:command! -range=% Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

silent! colorscheme nord

" Highlight text over 100 columns
highlight OverLength guifg=#ebcb8b gui=undercurl
let s:overlen=1 " TODO: can the current status be read instead of a variable?
function ToggleOverLength()
	if s:overlen
		highlight OverLength guibg=NONE guifg=NONE gui=NONE
		let s:overlen=0
	else
		highlight OverLength guifg=#ebcb8b gui=undercurl
		let s:overlen=1
	endif
endfunction
match OverLength /\%101v.\+/

" Statusline Syntastic warning
set statusline=%#warningmsg#%{SyntasticStatuslineFlag()}%0*
" Statusline left
set statusline+=%1*\ %<%f\ %m%r
" Middle
set statusline+=%0*%=
" Right
set statusline+=%{&fileformat}\ %{&fileencoding}\ %{&filetype}\ %1*%5.(%p%%%)\ %1*\ %3.l:%-3v
" Statusline colors
hi StatusLine guibg=#4c566a guifg=#d8dee9
hi User1 guibg=#3b4252 guifg=#d8dee9

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_compiler_options = '-include stdint.h -include stdbool.h'
let g:syntastic_asm_checkers = []

let g:AutoPairsCenterLine = 0

let g:goyo_height="100%"

" vim-gitgutter options
set updatetime=100

if $TERM == "linux"
	set notermguicolors
	colorscheme default
endif
