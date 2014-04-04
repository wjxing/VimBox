" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

runtime autoload/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

colorscheme darkblue

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

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

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" custom enviroment variable
set number
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set hlsearch
set showmatch

set autoindent
set cindent
set smartindent

set fileencodings=utf-8,gb18030,gbk,gb2312,cp936
set fileformats=unix,dos,mac

"set langmenu=zh_CN.UTF-8
"set helplang=cn

set nobackup
set noswapfile

"set foldmethod=indent

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview
highlight Pmenu    ctermbg=lightgrey  ctermfg=black
highlight PmenuSel ctermbg=lightblue  ctermfg=white
highlight IncSearch term=reverse ctermbg=1 gui=undercurl guisp=Red
highlight Search term=reverse ctermbg=1 gui=undercurl guisp=Red
highlight MatchParen ctermbg=blue ctermfg=white

let mapleader=","
" let g:netrw_winsize=30
set laststatus=2
" set ruler
set statusline=%F\ %h%m%r%=%-14.(%l,%c%V%)
set scrolloff=10


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

if filereadable("./lookuptags")
    let g:LookupFile_TagExpr = '"./lookuptags"'
    set tags+=~/.vim/tags/cos-sdk.tag;~/.vim/tags/cos-framework.tag;~/.vim/tags/cos-kernel.tag;~/.vim/tags/cos-common.tag;~/.vim/tags/cos-pdk.tag;~/.vim/tags/cos-androidrt.tag;~/.vim/tags/temp.tag;~/.vim/tags/linux-kernel.tag
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

let g:rainbow_active = 1
let g:rainbow_operators = 1
