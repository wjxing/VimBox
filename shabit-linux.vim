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
colorscheme gruvbox
"colorscheme solarized

" ctag with --relative-path=yes
set autochdir

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Highlight Settings             "
"                                     "
"""""""""""""""""""""""""""""""""""""""
"For solarized
"highlight Normal     ctermfg=252       ctermbg=none
"highlight LineNr     ctermbg=none

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Command Settings               "
"                                     "
"""""""""""""""""""""""""""""""""""""""
command -nargs=? Sudow :silent w !sudo tee % > /dev/null
command -nargs=1 Vdiff vertical diffsplit <args>

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Map define                    "
"                                     "
"""""""""""""""""""""""""""""""""""""""
nnoremap <silent>Wmb :marks<CR>
nnoremap <silent>Wg :Unite -silent -start-insert menu:git<CR>
nnoremap <silent>Wh <Plug>GitGutterNextHunk
nnoremap <silent>WH <Plug>GitGutterPrevHunk

" search this word in this file
nnoremap <silent>Ww :execute "lvimgrep /" . expand("<cword>") . "/j %*" <BAR> lopen<CR>
" search this word in this folder
nnoremap <silent>Wd :execute "lvimgrep /" . expand("<cword>") . "/gj **" <BAR> lopen<CR>
" search this select in this file
nnoremap <silent>W/ :set operatorfunc=WGrepOperator<CR>g@
vnoremap <silent>W/ :<c-u>call WGrepOperator(visualmode())<CR>

cnoremap <C-V> <C-R>+

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_SingleClick=1

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

let g:unite_source_menu_menus = get(g:,'unite_source_menu_menus',{})
let g:unite_source_menu_menus.git = {
    \ 'description' : '            gestionar repositorios git
        \                            [espacio]g',
    \}
let g:unite_source_menu_menus.git.command_candidates = [
    \['> tig                                                        gt',
        \'normal ,gt'],
    \['> git status       (Fugitive)                                gs',
        \'Gstatus'],
    \['> git diff         (Fugitive)                                gd',
        \'Gdiff'],
    \['> git commit       (Fugitive)                                gc',
        \'Gcommit'],
    \['> git log          (Fugitive)                                gl',
        \'exe "silent Glog | Unite quickfix"'],
    \['> git blame        (Fugitive)                                gb',
        \'Gblame'],
    \['> git stage        (Fugitive)                                gw',
        \'Gwrite'],
    \['> git checkout     (Fugitive)                                go',
        \'Gread'],
    \['> git rm           (Fugitive)                                gr',
        \'Gremove'],
    \['> git mv           (Fugitive)                                gm',
        \'exe "Gmove " input("destino: ")'],
    \['> git push         (Fugitive, salida por buffer)             gp',
        \'Git! push'],
    \['> git pull         (Fugitive, salida por buffer)             gP',
        \'Git! pull'],
    \['> git prompt       (Fugitive, salida por buffer)             gi',
        \'exe "Git! " input("comando git: ")'],
    \['> git cd           (Fugitive)',
        \'Gcd'],
    \]

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|jpg|png|jpeg)$',
  \ }


"""""""""""""""""""""""""""""""""""""""
"                                     "
"       function config               "
"                                     "
"""""""""""""""""""""""""""""""""""""""
function! WGrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    execute "lvimgrep /" . expand(@@) . "/j %"
    lopen

    let @@ = saved_unnamed_register
endfunction
