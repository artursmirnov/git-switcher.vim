" File: autoload/git_switcher/session_component/prev_branch_file.vim
" Author: ToruIwashita <toru.iwashita@gmail.com>
" License: MIT License

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! git_switcher#session_component#prev_branch_file#new(key) abort
  let l:obj = git_switcher#session_component#file_base#new(a:key)
  let l:obj._self = 'prev_branch_file'

  fun! l:obj.ext() abort
    return '.branch.prev.'.getpid().'.vim'
  endf

  fun! l:obj.escaped_glob_ext() abort
    return '\.branch\.prev\.'.getpid().'\.vim'
  endf

  return l:obj
endf

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
