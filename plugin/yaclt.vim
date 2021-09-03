if exists('g:loaded_yaclt')
  finish
endif
let g:loaded_yaclt = 1

command! -nargs=* Yaclt lua require('yaclt.utils.viml-command-parser').parse(<q-args>)
