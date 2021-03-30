packadd vim-commentary
au BufWritePost <buffer> silent !markdown -o /tmp/doc.html %
nnoremap <Leader>p :!markdown -o /tmp/doc.html %; $BROWSER /tmp/doc.html &<CR>
setlocal linebreak
setlocal spell
setlocal commentstring=<!---%s--->
nnoremap <Leader>/ gcc
vnoremap <Leader>/ gc
