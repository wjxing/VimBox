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

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       lookup plugin config          "
"                                     "
"""""""""""""""""""""""""""""""""""""""
if filereadable("./lookuptags")
    let g:LookupFile_TagExpr = '"./lookuptags"'
    " 不保存上次查找的字符串
    let g:LookupFile_PreserveLastPattern = 0
    " 回车打开第一个匹配项目
    let g:LookupFile_AlwaysAcceptFirst = 1
    " 不允许创建不存在的文件
    let g:LookupFile_AllowNewFiles = 0
    nmap <silent> <leader>lf :LUTags<cr>
    nmap <silent> <leader>lb :LUBufs<cr>
    nmap <silent> <leader>lw :LUWalk<cr>
endif

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       global/cscope plugin config   "
"                                     "
"""""""""""""""""""""""""""""""""""""""
"function! UpdateGtags(f)
"    let dir = fnamemodify(a:f, ':p:h')
"    exe 'silent !cd ' . dir . ' && global -u &>/dev/null &'
"endfunction

let _OWN_INDEX_SUPPORT=0
"if filereadable(glob('/usr/bin/gtags'))
"    if filereadable("GTAGS")
"        let _OWN_INDEX_SUPPORT=1
"        set csprg=/usr/bin/gtags-cscope
"        set nocsverb
"        cs add GTAGS
"        ser csverb
"        au BufWritePost *.java call UpdateGtags(expand('<afile>'))
"        au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))
"        au BufWritePost *.cpp call UpdateGtags(expand('<afile>'))
"    endif
"endif

if has("cscope")
    if filereadable("cscope.out")
        let _OWN_INDEX_SUPPORT=1
        set csprg=/usr/bin/cscope
        set nocsverb
        cs add cscope.out
        set csverb
    endif
endif

if _OWN_INDEX_SUPPORT
    " search cscope file first, NOT tag file
    set csto=0
    " search cscope and tag file
    set cst
    " set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
    " s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
    " g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
    " c: 查找调用本函数的函数
    " t: 查找指定的字符串
    " e: 查找egrep模式，相当于egrep功能，但查找速度快多了
    " f: 查找并打开文件，类似vim的find功能
    " i: 查找包含本文件的文件
    " d: 查找本函数调用的函数
    nmap <C-\>s :cscope find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cscope find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cscope find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cscope find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cscope find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cscope find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cscope find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cscope find d <C-R>=expand("<cword>")<CR><CR>
endif

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
