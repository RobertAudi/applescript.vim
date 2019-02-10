autocmd BufNewFile,BufRead *.applescript,*.scpt,*scptd setfiletype applescript
autocmd BufNewFile,BufRead *
      \ if getline(1) =~? '^#!.*\<osascript\>'
      \ | setfiletype applescript |
      \ endif
