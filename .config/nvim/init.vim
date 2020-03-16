"  _       _ _         _
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
" Run on nvim start

set number relativenumber
set cursorline
set listchars+=tab:\|\ ,trail:~,extends:>,precedes:<
set list
set tabstop=4
set shiftwidth=4
set backspace=start,indent
set mouse=a
tab ball
syntax on

" Fix some keys on finnish keyboard layout
map ¤ $
map Ö :
map & ^

call plug#begin()

" Colorscheme
Plug 'morhetz/gruvbox'

" Syntax checking
Plug 'scrooloose/syntastic'

" Completion engine
Plug 'ervandew/supertab'

" Openscad syntax highlighting
Plug 'sirtaj/vim-openscad'

" Automatically close html tags
Plug 'alvan/vim-closetag'

" Git control through vim
Plug 'airblade/vim-gitgutter'

call plug#end()

" Set gruvbox as colorscheme
set termguicolors
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Syntastic options
set statusline=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_compiler_options = '-include stdint.h -include stdbool.h'

" vim-gitgutter options
set updatetime=100

vmap <C-c> "+y
map <C-p> "+p
