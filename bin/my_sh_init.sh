#!/bin/bash

PATH=~/.vim/plugin/bin:~/.vim/plugin/bin/global/bin:$PATH

function __W_GEN_TAGS_INTER() {
    local c IFS=' '$'\t'$'\n'
    for c in $1; do
        case "$c" in
        *=) printf %s$'\n' "$c" ;;
        *)  printf %s$'\n' "$c " ;;
        esac
    done
}

function __W_GEN_TAGS_IMP() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local IFS=$'\n'
    COMPREPLY=($(compgen -W "$(__W_GEN_TAGS_INTER "${1}")" -- "$cur"))
}

function __W_GEN_TAGS_COMP() {
    __W_GEN_TAGS_IMP "clean cpp dis_expand_tab include= java temp tname= prune="
}

complete -o nospace -F __W_GEN_TAGS_COMP gen_global_tags
