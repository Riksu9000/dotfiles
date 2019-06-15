set number relativenumber
set cursorline
set listchars+=tab:\|\ ,trail:~,extends:>,precedes:<
set list
syntax on

call plug#begin()

" Colorscheme
Plug 'morhetz/gruvbox'

" Syntax checking
Plug 'scrooloose/syntastic'

" Completion engine
Plug 'ervandew/supertab'

Plug 'sirtaj/vim-openscad'

call plug#end()

" Set gruvbox as colorscheme
set termguicolors
colorscheme gruvbox

" Syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

vmap <C-c> "+y
map <C-p> "+p
