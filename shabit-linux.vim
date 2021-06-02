if !has("unix")
    finish
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark
"colorscheme darkblue

" export TERM=xterm-256color
"let g:solarized_termcolors=256
set background=dark
colorscheme gruvbox
"colorscheme solarized

" ctag with --relative-path=yes
set autochdir

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Highlight Settings            "
"                                     "
"""""""""""""""""""""""""""""""""""""""
"For solarized
"highlight Normal     ctermfg=252       ctermbg=none
"highlight LineNr     ctermbg=none

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Command Settings              "
"                                     "
"""""""""""""""""""""""""""""""""""""""
command -nargs=? Sudow :silent w !sudo tee % > /dev/null
command -nargs=1 Vdiff vertical diffsplit <args>

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       Map define                    "
"                                     "
"""""""""""""""""""""""""""""""""""""""
nnoremap <silent><leader>mb :marks<CR>
nnoremap <silent><leader>g :Unite -silent -start-insert menu:git<CR>
nnoremap <silent><leader>h <Plug>GitGutterNextHunk
nnoremap <silent><leader>H <Plug>GitGutterPrevHunk
nmap <silent> <F8> <Plug>MarkdownPreview
imap <silent> <F8> <Plug>MarkdownPreview
nmap <silent> <F9> <Plug>StopMarkdownPreview
imap <silent> <F9> <Plug>StopMarkdownPreview

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       tlist plugin config           "
"                                     "
"""""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_SingleClick=1

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       slimv plugin config           "
"                                     "
"""""""""""""""""""""""""""""""""""""""
if filereadable("/usr/bin/sbcl")
  packadd slimv
  let g:slimv_swank_cmd = '! tmux split-window -h "rlwrap sbcl --load ~/.vim/pack/myplugins/opt/slimv/slime/start-swank.lisp"'
endif

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       fzf plugin config             "
"                                     "
"""""""""""""""""""""""""""""""""""""""
if isdirectory(expand("$HOME/.fzf"))
  packadd fzf
  set rtp+=~/.fzf
endif

"""""""""""""""""""""""""""""""""""""""
"                                     "
"       global plugin config          "
"                                     "
"""""""""""""""""""""""""""""""""""""""
"if filereadable("/usr/bin/global")
"  let loadtag = "loadtag.name"
"  if $LOAD_TAG != ""
"    let loadtag = $LOAD_TAG
"  endif
"  if filereadable(loadtag)
"    packadd gtags
"    for line in readfile(loadtag)
"      let loadtag_vim = $HOME . '/.vim/tags/' . line . '/loadtag.vim'
"      if filereadable(loadtag_vim)
"        execute "source " . loadtag_vim
"      endif
"    endfor
"  endif
"endif

if filereadable("/usr/bin/global")
  let tags_list_file = $HOME . '/.vim/tags/tags_list'
  let cur_abs_path = expand('%:p:h')
  let tag_name_give = ""
  if $TAG_NAME != ""
    let tag_name_give = $TAG_NAME
  endif
  if filereadable(tags_list_file)
    for line in readfile(tags_list_file)
      let tag_name_path = split(line, ":")
      if len(tag_name_path) != 2
        continue
      endif
      let tag_name = tag_name_path[0]
      let tag_path = tag_name_path[1]
      let is_path_match = stridx(cur_abs_path, tag_path)
      if is_path_match != 0
        continue
      endif
      if tag_name_give != "" && tag_name_give != tag_name
        continue
      endif
      let tag_vim = $HOME . '/.vim/tags/' . tag_name . '/loadtag.vim'
      if filereadable(tag_vim)
        packadd gtags
        execute "source " . tag_vim
        break
      endif
    endfor
  endif
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

