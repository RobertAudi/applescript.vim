if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

setlocal autoindent
setlocal indentexpr=GetAppleScriptIndent()
setlocal indentkeys+=!^F,o,O,0=if,0=else,0=end,0=repeat,0=tell
setlocal nosmartindent

" Restore when changing filetype.
let b:undo_indent = 'setlocal autoindent< indentexpr< indentkeys< nosmartindent<'

if !exists("g:applescript_default_indent")
  let g:applescript_default_indent = &shiftwidth
endif

if !exists('*GetAppleScriptIndent')
  function! GetAppleScriptIndent() abort
    if v:lnum == 0
      return 0
    endif

    let lnum = prevnonblank(v:lnum - 1)

    let ind = indent(lnum)
    if ind == 0
      let ind = g:applescript_default_indent
    endif

    let line = getline(lnum)
    if line =~? '^\s*\<if\>'
      if substitute(line, '--.*$', '', '') =~? '\<then\>\s*$'
        let ind += &shiftwidth
      endif
    endif

    if line =~? '^\s*\<tell\>'
      if line !~? '\<to\>'
        let ind += &shiftwidth
      endif
    endif

    if line =~? '^\s*\<repeat\>\|^\s*\<on\>\|^\s*\<else\>\|^\s*\<with\>'
      let ind += &shiftwidth
    endif

    let line = getline(v:lnum)
    if line =~? '^\s*\<end\>\|^\s*\<else\>'
      let ind -= &shiftwidth
    endif

    return ind
  endfunction
endif

let &cpo = s:save_cpo
unlet s:save_cpo
