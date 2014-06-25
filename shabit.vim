" use vim --cmd "let loaded_shabit=1"
if !exists('loaded_shabit')
    finish
endif

let mapleader=","
colorscheme darkblue

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview
highlight Pmenu    ctermbg=lightgrey  ctermfg=black
highlight PmenuSel ctermbg=lightblue  ctermfg=white
highlight IncSearch term=reverse ctermbg=1 gui=undercurl guisp=Red
highlight Search term=reverse ctermbg=1 gui=undercurl guisp=Red
highlight MatchParen ctermbg=blue ctermfg=white

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

set laststatus=2
set statusline=%F\ %h%m%r%=%-14.(%l,%c%V%)
set scrolloff=10
" let g:netrw_winsize=30
" set ruler

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set incsearch		" Incremental search.
set hlsearch        " Highlight search.
set mouse=a		    " Enable mouse usage (all modes).
"set ignorecase		" Do case insensitive matching.
"set smartcase		" Do smart case matching.
"set autowrite		" Automatically save before commands like :next and :make.
"set hidden         " Hide buffers when they are abandoned.

set number
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set smartindent
set autoindent
set cindent

set fileencodings=utf-8,gb18030,gbk,gb2312,cp936
set fileformats=unix,dos,mac

"set langmenu=zh_CN.UTF-8
"set helplang=cn

set nobackup
set noswapfile

"set foldmethod=indent

set list
set listchars=tab:>-,trail:$

set grepprg=grep\ --exclude-dir=svn\ --exclude-dir=\.git\ -rns
"set path=.

command -nargs=? Sudow :silent w !sudo tee % > /dev/null
"iabbrev mmain int main() {<CR>!cursor!<LF>}<Esc>:call search('!cursor!','b')<CR>cf!

"""""""""""""""""""""""""""""""""""""""
"                                     "
"            Map define               "
"                                     "
"""""""""""""""""""""""""""""""""""""""
" inoremap <LEFT> <NOP>
" inoremap <RIGHT> <NOP>
" inoremap <UP> <NOP>
" inoremap <DOWN> <NOP>
" inoremap <ESC> <NOP>
" inoremap jk <ESC>l

nmap Wyw viw"+y
nmap <silent> Wyf :let @+=expand('%:t')<CR>
nmap <silent> Wyp :let @+=expand('%')<CR>

nmap <leader>mn :TMiniBufExplorer<cr>

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

let g:vimwiki_list = [{'path': '/root/workspace/builder/cplus/wiki',
  \ 'diary_link_count': 5}]

function! CapitalizeCenterAndMoveDown()
    s/\<./\u&/g
    center
    +1
endfunction

nmap <silent> \c :call CapitalizeCenterAndMoveDown()<CR>

"""""""""""""""""""""""""""""""""""""""
"                                     "
"     minibuf plugin config           "
"                                     "
"""""""""""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1
if has("autochdir")
    let g:miniBufExplorerMoreThanOne = 0
    set autochdir
else
    let g:vimgdb_debug_file=""
    run <silent>  macros/gdb_mappings.vim
endif

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       lookup plugin config          "
"                                     "
"""""""""""""""""""""""""""""""""""""""
if filereadable("./lookuptags")
    let g:LookupFile_TagExpr = '"./lookuptags"'
    "set tags+=~/.vim/tags/temp.tag;~/.vim/tags/linux-kernel.tag
endif
"不保存上次查找的字符串
let g:LookupFile_PreserveLastPattern = 0
"回车打开第一个匹配项目
let g:LookupFile_AlwaysAcceptFirst = 1
"不允许创建不存在的文件
let g:LookupFile_AllowNewFiles = 0
"映射LookupFile为,lk
nmap <silent> <leader>lf :LUTags<cr>
"映射LUBufs为,ll
nmap <silent> <leader>lb :LUBufs<cr>
"映射LUWalk为,lw
nmap <silent> <leader>lw :LUWalk<cr>

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       cscope plugin config          "
"                                     "
"""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  if filereadable("cscope.out")
    cs add cscope.out
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
"  set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
endif
"s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
"g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
"d: 查找本函数调用的函数
"c: 查找调用本函数的函数
"t: 查找指定的字符串
"e: 查找egrep模式，相当于egrep功能，但查找速度快多了
"f: 查找并打开文件，类似vim的find功能
"i: 查找包含本文件的文件
nmap <C-\>s :cscope find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cscope find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cscope find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cscope find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cscope find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cscope find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cscope find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cscope find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       rainbow plugin config         "
"                                     "
"""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1
let g:rainbow_operators = 1