if !has("unix")
    finish
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark
"colorscheme darkblue

" export TERM=xterm-256color
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" ctag with --relative-path=yes
set autochdir

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Highlight Settings             "
"                                     "
"""""""""""""""""""""""""""""""""""""""
highlight Normal     ctermfg=252       ctermbg=none
highlight LineNr     ctermbg=none

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Command Settings               "
"                                     "
"""""""""""""""""""""""""""""""""""""""
command -nargs=? Sudow :silent w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Map define                    "
"                                     "
"""""""""""""""""""""""""""""""""""""""
nnoremap <F3> :execute "vimgrep /" . expand("<cword>") . "/j %*" <BAR> cw<CR>
nnoremap <F4> :execute "vimgrep /" . expand("<cword>") . "/gj **" <BAR> cw<CR>

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       minibuf plugin config         "
"                                     "
"""""""""""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplorerMoreThanOne = 0

if filereadable("loadtag.vim")
    source loadtag.vim
endif

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       rainbow plugin config         "
"                                     "
"""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1
let g:rainbow_operators = 1
