" git-switcher
" Author:  Toru Hoyano <toru.iwashita@gmail.com>
" License: This file is placed in the public domain.

if exists('g:loaded_git_switcher')
  finish
endif
let g:loaded_git_switcher = 1

command! -nargs=? -complete=customlist,git_switcher#_stored_sessions GswSave call git_switcher#save_session(<f-args>)
command! -nargs=? -complete=customlist,git_switcher#_stored_sessions GswLoad call git_switcher#load_session(<f-args>)
command! -bang -nargs=1 -complete=customlist,git_switcher#git#_branches Gsw call git_switcher#gsw(<f-args>,<bang>0)
command! -bang -nargs=1 -complete=customlist,git_switcher#git#_remote_only_branches GswRemote call git_switcher#gsw(<f-args>,<bang>0)
