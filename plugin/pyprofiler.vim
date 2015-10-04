" version: 0.9.0
" author : wan <one_kkm@icloud.com>
" license: mit license

if exists("g:loaded_pyprofiler")
  finish
endif
let g:loaded_pyprofiler = 1
let s:save_cpo = &cpo
set cpo&vim

command! Pyp call pyprofiler#pypro()

let &cpo = s:save_cpo
unlet s:save_cpo
