packadd vim-commentary
command MakePreview execute '!echo "<\!DOCTYPE html>" > /tmp/doc.html; markdown -S % >> /tmp/doc.html'
autocmd BufWritePost <buffer> silent MakePreview
nnoremap <Leader>p :MakePreview<CR>:!$BROWSER /tmp/doc.html &<CR>
setlocal linebreak
setlocal spell
setlocal commentstring=<!---%s--->
nnoremap <Leader>/ gcc
vnoremap <Leader>/ gc
