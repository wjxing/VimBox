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

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Highlight Settings             "
"                                     "
"""""""""""""""""""""""""""""""""""""""
highlight IncSearch  term=reverse      ctermbg=1     gui=undercurl guisp=Red
highlight MatchParen ctermbg=blue      ctermfg=white
highlight Pmenu      ctermbg=lightgrey ctermfg=black
highlight PmenuSel   ctermbg=lightblue ctermfg=white
highlight Search     term=reverse      ctermbg=1     gui=undercurl guisp=Red

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
"       Map define                    "
"                                     "
"""""""""""""""""""""""""""""""""""""""
nnoremap <silent> Wyw viw"+y
nnoremap <silent> Wyf :let @+=expand('%:t')<CR>
nnoremap <silent> Wyp :let @+=expand('%')<CR>
nnoremap <c-left> <c-w><left>
nnoremap <c-right> <c-w><right>
nnoremap <c-up> <c-w><up>
nnoremap <c-down> <c-w><down>

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
" inoremap <LEFT>  <NOP>
" inoremap <RIGHT> <NOP>
" inoremap <UP>    <NOP>
" inoremap <DOWN>  <NOP>
" inoremap <ESC>   <NOP>
" inoremap jk      <ESC>l

