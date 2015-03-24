" use vim --cmd "let loaded_shabit=1"
if !exists('loaded_shabit')
    finish
endif

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Basic Settings                "
"                                     "
"""""""""""""""""""""""""""""""""""""""
let mapleader=","

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
colorscheme darkblue

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set hlsearch  " Highlight search.
set incsearch " Incremental search.
set mouse=a   " Enable mouse usage (all modes).
set showcmd   " Show (partial) command in status line.
set showmatch " Show matching brackets.

set autoindent
set cindent
set expandtab
set nobackup
set noswapfile
set number
set shiftwidth=4
set smartindent
set smarttab
set tabstop=4

set fileencodings=utf-8,gb18030,gbk,gb2312,cp936
set fileformats=unix,dos,mac

set list
set listchars=tab:>-,trail:$

set laststatus=2
set statusline=%F\ %h%m%r%=%-14.(%l,%c%V%)
set scrolloff=10

" ctag with --relative-path=yes
set autochdir

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Highlight Settings             "
"                                     "
"""""""""""""""""""""""""""""""""""""""
highlight IncSearch  term=reverse ctermbg=1                       gui=undercurl guisp=Red
highlight MatchParen              ctermbg=blue      ctermfg=white
highlight Pmenu                   ctermbg=lightgrey ctermfg=black
highlight PmenuSel                ctermbg=lightblue ctermfg=white
highlight Search     term=reverse ctermbg=1                       gui=undercurl guisp=Red

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Autocmd Settings               "
"                                     "
"""""""""""""""""""""""""""""""""""""""
if has("autocmd")
" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
  filetype plugin indent on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
endif

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
" inoremap <LEFT>  <NOP>
" inoremap <RIGHT> <NOP>
" inoremap <UP>    <NOP>
" inoremap <DOWN>  <NOP>
" inoremap <ESC>   <NOP>
" inoremap jk      <ESC>l

nnoremap <silent> Wyw viw"+y
nnoremap <silent> Wyf :let @+=expand('%:t')<CR>
nnoremap <silent> Wyp :let @+=expand('%')<CR>

function! CapitalizeCenterAndMoveDown()
    s/\<./\u&/g
    center
    +1
endfunction
nnoremap <silent> Wc :call CapitalizeCenterAndMoveDown()<CR>

" * and # to search in v-mode selected
vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

nnoremap <F3> :execute "vimgrep /" . expand("<cword>") . "/j %*" <BAR> cw<CR>
nnoremap <F3> :execute "vimgrep /" . expand("<cword>") . "/gj **" <BAR> cw<CR>

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       vimwiki plugin config         "
"                                     "
"""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '/root/workspace/builder/cplus/wiki',
  \ 'diary_link_count': 5}]

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
function! UpdateGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    exe 'silent !cd ' . dir . ' && global -u &>/dev/null &'
endfunction

let _OWN_INDEX_SUPPORT=0
if filereadable(glob('/usr/local/bin/global/bin/gtags'))
    if filereadable("GTAGS")
        let _OWN_INDEX_SUPPORT=1
        set csprg=/usr/local/bin/global/bin/gtags-cscope
        set nocsverb
        cs add GTAGS
        ser csverb
        au BufWritePost *.java call UpdateGtags(expand('<afile>'))
        au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))
        au BufWritePost *.cpp call UpdateGtags(expand('<afile>'))
    endif
endif

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

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Settings Stash         "
"                                     "
"""""""""""""""""""""""""""""""""""""""
" set completeopt=menu,preview
" set ruler
" set ignorecase		" Do case insensitive matching.
" set smartcase		" Do smart case matching.
" set autowrite		" Automatically save before commands like :next and :make.
" set hidden         " Hide buffers when they are abandoned.
" set langmenu=zh_CN.UTF-8
" set helplang=cn
" set foldmethod=indent
" set grepprg=grep\ --exclude-dir=svn\ --exclude-dir=\.git\ -rns
" set path=.
" let g:netrw_winsize=30
" iabbrev mmain int main() {<CR>!cursor!<LF>}<Esc>:call search('!cursor!','b')<CR>cf!
" if has("autochdir")
"     let g:miniBufExplorerMoreThanOne = 0
"     set autochdir
" else
"     let g:vimgdb_debug_file=""
"     run <silent>  macros/gdb_mappings.vim
" endif
