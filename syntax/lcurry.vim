" Vim syntax file
" Language:         Curry with literate comments, Bird style,
"                   TeX style and plain text surrounding
"                   \begin{code} \end{code} blocks
" Author:           Sven Hüser <s.hueser@gmail.com>
"
" Adapted and extended lhaskell.vim
" This style guesses as to the type of markup used in a literate haskell
" file and will highlight (La)TeX markup if it finds any
" This behaviour can be overridden, both glabally and locally using
" the lcurry_markup variable or b:lcurry_markup variable respectively.
"
" lcurry_markup     must be set to either  tex  or  none  to indicate that
"                   you always want (La)TeX highlighting or no highlighting
"                   must not be set to let the highlighting be guessed
" b:lcurry_markup   must be set to eiterh  tex  or  none  to indicate that
"                   you want (La)TeX highlighting or no highlighting for
"                   this particular buffer
"                   must not be set to let the highlighting be guessed

if exists("b:current_syntax")
  finish
endif

" First off, see if we can inherit a user preference for lcurry_markup
if !exists("b:lcurry_markup")
    if exists("lcurry_markup")
        if lcurry_markup =~ '\<\%(tex\|none\)\>'
            let b:lcurry_markup = matchstr(lcurry_markup,'\<\%(tex\|none\)\>')
        else
            echohl WarningMsg | echo "Unknown value of lcurry_markup" | echohl None
            let b:lcurry_markup = "unknown"
        endif
    else
        let b:lcurry_markup = "unknown"
    endif
else
    if b:lcurry_markup !~ '\<\%(tex\|none\)\>'
        let b:lcurry_markup = "unknown"
    endif
endif

" Remember where the cursor is, and go to upperleft
let s:oldline=line(".")
let s:oldcolumn=col(".")
call cursor(1,1)

" If no user preference, scan buffer for our guess of the markup to
" highlight. We only differentiate between TeX and plain markup, where
" plain is not highlighted. The heuristic for finding TeX markup is if
" one of the following occurs anywhere in the file:
"   - \documentclass
"   - \begin{env}       (for env != code)
"   - \part, \chapter, \section, \subsection, \subsubsection, etc
if b:lcurry_markup == "unknown"
    if search('\\documentclass\|\\begin{\(code}\)\@!\|\\\(sub\)*section\|\\chapter|\\part','W') != 0
        let b:lcurry_markup = "tex"
    else
        let b:lcurry_markup = "plain"
    endif
endif

" If user wants us to highlight TeX syntax or guess thinks it's TeX, read it.
if b:lcurry_markup == "tex"
    runtime! syntax/tex.vim
    unlet b:current_syntax
    " Tex.vim removes "_" from 'iskeyword', but we need it for Curry.
    setlocal isk+=_
    syntax cluster lcurryTeXContainer contains=tex.*Zone,texAbstract
else
    syntax cluster lcurryTeXContainer contains=.*
endif

" Literate Curry is Curry in between text, so at least read Curry highlighting
syntax include @curryTop syntax/curry.vim

syntax region lcCurryBirdTrack          start="^>" end="\%(^[^>]\)\@=" contains=@curryTop,lcurryBirdTrack containedin=@lcurryTeXContainer
syntax region lcCurryFlippedBirdTrack   start="^<" end="\%(^[^<]\)\@=" contains=@curryTop,lcurryFlippedBirdTrack containedin=@lcurryTeXContainer
syntax region lcCurryBeginEndBlock      start="^\\begin{code}\s*$" matchgroup=NONE end="\%(^\\end{code}.*$\)\@=" contains=@curryTop,beginCodeBegin containedin=@lcurryTeXContainer
syntax region lcCurryBeginEndBlock      start="^\\begin{spec}\s*$" matchgroup=NONE end="\%(^\\end{spec}.*$\)\@=" contains=@curryTop,beginCodeBegin containedin=@lcurryTeXContainer

syntax match lcurryBirdTrack            "^>" contained
syntax match lcurryFlippedBirdTrack     "^<" contained

syntax match  beginCodeBegin  "^\\begin" nextgroup=beginCodeCode contained
syntax region beginCodeCode   matchgroup=texDelimiter start="{" end="}"


hi def link lcurryBirdTrack         Comment
hi def link lcurryFlippedBirdTrack  Comment

hi def link beginCodeBegin          texCmdName
hi def link beginCodeCode           texSection

" Restore cursor to original position, as it may have been disturbed
" by the searches in our guessing code
call cursor (s:oldline, s:oldcolumn)

unlet s:oldline
unlet s:oldcolumn

let b:current_syntax = "lcurry"
