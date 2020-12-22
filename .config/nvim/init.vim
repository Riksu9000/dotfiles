set backspace=start,indent
set clipboard=unnamedplus
set cursorline
set list
set listchars+=tab:\⎢\ ,trail:~,extends:>,precedes:<
set mouse=a
set noswapfile
set number relativenumber
set shiftwidth=4
set tabstop=4
set termguicolors
set wildmode=longest:full,full
set wildmenu
:vertical ball

syntax on

let mapleader=' '

" Fix some keys on finnish keyboard layout
map ¤ $
map Ö :
map & ^

"Conflicts with vim-gitgutter
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>s :SyntasticToggleMode<CR>
nnoremap <Leader>o :call ToggleOverLength()<CR>
nnoremap <Leader>O :!open %<CR>

command Sudowrite execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

call plug#begin()

" Colorscheme
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

" Syntax checking
Plug 'scrooloose/syntastic'

" Completion engine
Plug 'ervandew/supertab'

" Automatically close html tags
Plug 'alvan/vim-closetag'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Syntax highlighting
Plug 'maxbane/vim-asm_ca65'
Plug 'sirtaj/vim-openscad'

Plug 'ap/vim-css-color'

call plug#end()

colorscheme nord

" Highlight text over 100 columns
highlight OverLength guibg=#804147
let s:overlen=1 " TODO: can the current status be read instead of a variable?
function ToggleOverLength()
	if s:overlen
		highlight OverLength guibg= guifg=
		let s:overlen=0
	else
		highlight OverLength guibg=#804147
		let s:overlen=1
	endif
endfunction
match OverLength /\%101v.\+/

" Syntastic options
set statusline=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%0*

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

" vim-gitgutter options
set updatetime=100

au BufReadPost *.asm set filetype=asm_ca65
au BufReadPost *.rasi set filetype=css
