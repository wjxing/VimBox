if !has("win32")
    finish
endif

" molokai
set t_Co=256
set background=dark
colorscheme gruvbox
set cursorline

set guifont=Bitstream_Vera_Sans_Mono:h11:cANSI
set gfw=Microsoft_YaHei_Mono:h11.5:cGB2312
set backspace=indent,eol,start
set go-=T
set go-=m
set go-=L
set go-=r
cmap <C-V>  <C-R>+
nnoremap <F3> :execute "vimgrep /" . expand("<cword>") . "/ %" <CR> :copen 30<CR>

autocmd GUIEnter * simalt ~x
nnoremap <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
