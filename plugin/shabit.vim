if !exists('loaded_shabit')
    finish
endif

set list
set listchars=tab:>-,trail:$

command -nargs=? Sudow :silent w !sudo tee % > /dev/null

" inoremap <LEFT> <NOP>
" inoremap <RIGHT> <NOP>
" inoremap <UP> <NOP>
" inoremap <DOWN> <NOP>
" inoremap <ESC> <NOP>
" inoremap jk <ESC>l

""""""""""""""""SELF""""""""""""""""""""
nmap Wyw viw"+y
nmap <silent> Wyf :let @+=expand('%:t')<CR>
nmap <silent> Wyp :let @+=expand('%')<CR>
iabbrev mmain int main() {<CR>!cursor!<LF>}<Esc>:call search('!cursor!','b')<CR>cf!

nmap <leader>mn :TMiniBufExplorer<cr>
""""""""""""""""SELF""""""""""""""""""""

""""""""""""""""v-mode search"""""""""""
"* and # to search in v-mode selected
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
""""""""""""""""v-mode search"""""""""""

let g:vimwiki_list = [{'path': '/root/workspace/builder/cplus/wiki',
  \ 'diary_link_count': 5}]

function! CapitalizeCenterAndMoveDown()
    s/\<./\u&/g
    center
    +1
endfunction

nmap <silent> \c :call CapitalizeCenterAndMoveDown()<CR>

set grepprg=grep\ --exclude-dir=svn\ --exclude-dir=\.git\ -rns
"set path=.
