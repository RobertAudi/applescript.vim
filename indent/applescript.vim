"if exists("b:did_indent") | finish | endif
"let b:did_indent=1

setlocal autoindent
setlocal indentexpr=GetIndent()
setlocal indentkeys+=!^F,o,O,0=if,0=else,0=end,0=repeat,0=tell
setlocal nosmartindent

if !exists("g:applescript_default_indent")
    let g:applescript_default_indent = &sw
endif

fun! GetIndent()
    if v:lnum = 0 then
        return 0
    endif

    let lnum = prevnonblank(v:lnum - 1)

    let ind = indent(lnum)
    if ind == 0 then
        let ind = g:applescript_default_indent
    endif
    let line = getline(lnum)
    if line =~ '^\s*\<if\>'
        if substitute(line, '--.*$', '', '') =~ '\<then\>\s*$'
            let ind += &sw
        endif
    endif

    if line =~ '^\s*\<tell\>'
        if line !~ '\<to\>'
            let ind += &sw
        endif
    endif

    if line =~ '^\s*\<repeat\>\|^\s*\<on\>\|^\s*\<else\>\|^\s*\<with\>'
        let ind += &sw
    endif

    let line = getline(v:lnum)
    if line =~ '^\s*\<end\>\|^\s*\<else\>'
        let ind -= &sw
    endif

    return ind
endf
