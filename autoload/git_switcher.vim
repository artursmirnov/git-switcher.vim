" git-switcher
" Author:  ToruIwashita <toru.iwashita@gmail.com>
" License: This file is placed in the public domain.

if exists('g:loaded_git_switcher')
  finish
endif
let g:loaded_git_switcher = 1

let s:cpo_save = &cpo
set cpo&vim

fun! git_switcher#new(...)
  let obj = {}
  let obj.git   = git_switcher#git#new()
  let obj.state = git_switcher#state#new()
  if a:0
    let obj.session = git_switcher#session#new(obj.git.project().'/'.a:1)
  else
    let obj.session = git_switcher#session#new(obj.git.project().'/'.obj.git.current_branch())
  endif

  fun! obj.save_session()
    call self.session.store()
    echo "save '".self.session.get_name()."' session."
  endf

  fun! obj.load_session()
    if !self.session.file_exist()
      echo 'session file does not exist.'
      return 0
    endif

    call self.state.delete_all_buffers()
    call self.session.restore()
    echo "load '".self.session.get_name()."' session."
  endf

  fun! obj.git_switch(branch,bang)
    if !a:bang && confirm("save '".self.git.current_branch()."' session?", "&Yes\n&No") == 1
      call self.save_session()
    endif

    call self.git.switch(a:branch)

    let self.session = git_switcher#session#new(self.git.project().'/'.a:branch)
    call self.load_session()
  endf

  return obj
endf

fun! git_switcher#save_session(...)
  let git_switcher = call('git_switcher#new', a:000)
  call git_switcher.save_session()
endf

fun! git_switcher#load_session(...)
  let git_switcher = call('git_switcher#new', a:000)
  call git_switcher.load_session()
endf

fun! git_switcher#gsw(branch,bang)
  let git_switcher = call('git_switcher#new', a:000)
  call git_switcher.git_switch(a:branch,a:bang)
endf

let &cpo = s:cpo_save
unlet s:cpo_save