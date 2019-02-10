if exists('b:did_aplscptfiletype') | finish | endif
let b:did_aplscptfiletype=1
au BufNewFile,BufRead *.applescript,*.scpt,*scptd setf applescript
