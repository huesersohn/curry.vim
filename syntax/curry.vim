" Vim syntax file
" Language:         Curry
" Author:           Sven Hüser <s.hueser@gmail.com>
" 
" Adapted and extended haskell.vim


if exists("b:current_syntax")
    finish
endif

" (Qualified) identifiers (no default highlighting)
syn match ConId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[A-Z][a-zA-Z0-9_']*\>"
syn match VarId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[a-z][a-zA-Z0-9_']*\>"

" Infix operators--most punctuation characters and any (qualified) identifier
" enclosed in `backquotes`. An operator starting with : is a constructor,
" others are variables (e.g. functions).
syn match curryVarSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~.][-!#$%&\*\+/<=>\?@\\^|~:.]*"
syn match curryConSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*"
syn match curryVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
syn match curryConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"

" Reserved symbols--cannot be overloaded.
syn match curryDelimiter  "(\|)\|\[\|\]\|,\|;\|_\|{\|}"

" Strings and constants
syn match   curryStringUnknownEsc   contained "\\[A-Z]\+"
syn match   currySpecialChar        contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match   currySpecialChar        contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match   currySpecialCharError   contained "\\&\|'''\+"
syn region  curryString             start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=currySpecialChar,curryStringUnknownEsc
syn match   curryCharacter          "[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=currySpecialChar,currySpecialCharError,curryStringUnknownEsc
syn match   curryCharacter          "^'\([^\\]\|\\[^']\+\|\\'\)'" contains=currySpecialChar,currySpecialCharError
syn match   curryNumber             "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>\|\<0[bB][01]\+\>"
syn match   curryFloat              "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

" Keyword definitions. These must be patters instead of keywords
" because otherwise they would match as keywords at the start of a
" "literate" comment (see lhs.vim).
syn match curryModule       "\<module\>"
syn match curryImport       "\<import\>.*"he=s+6 contains=curryImportMod,curryLineComment,curryBlockComment,curryOwnType,curryType,curryFunction
syn match curryImportMod    contained "\<\(as\|qualified\|hiding\)\>"
syn match curryInfix        "\<\(infix\|infixl\|infixr\)\>"
syn match curryStructure    "\<\(data\|where\)\>"
syn match curryTypedef      "\<\(type\|newtype\)\>"
syn match curryStatement    "\<\(do\|case\|of\|let\|in\)\>"
syn match curryConditional  "\<\(if\|then\|else\|when\|unless\)\>"
syn match curryKeyword      "\<free\>"

syn match curryOwnType  "\<[A-Z][0-9A-Za-z_]*\>"
syn match curryType     "\<\(Bool\|Char\|Either\|Float\|Int\|IO\|Maybe\|Ordering\|String\|Success\)\>"

" Constants from the standard prelude.
syn match curryBoolean  "\<\(True\|False\)\>"
syn match curryMaybe    "\<\(Nothing\|Just\)\>"
syn match curryEither "\<\(Left\|Right\)\>"
syn match curryOrdering "\<\(GT\|LT\|EQ\)\>"

" Functions from the standard prelude.
syn match curryFunction "\<\(and\|all\|any\|appendFile\)\>"
syn match curryFunction "\<\(best\|break\|browse\|browseList\)\>"
syn match curryFunction "\<\(chr\|concat\|concatMap\|const\|curry\)\>"
syn match curryFunction "\<\(div\|done\|doSolve\|drop\|dropWhile\)\>"
syn match curryFunction "\<\(either\|elem\|ensureNotFree\|ensureSpine\|enumFrom\|enumFromThen\|enumFromTo\|enumFromThenTo\|error\)\>"
syn match curryFunction "\<\(failed\|filter\|findall\|flip\|foldl\|foldl1\|foldr\|foldr1\|fst\)\>"
syn match curryFunction "\<\(getChar\|getLine\)\>"
syn match curryFunction "\<\(id\|if_then_else\|iterate\)\>"
syn match curryFunction "\<\(head\)\>"
syn match curryFunction "\<\(length\|lines\|lookup\)\>"
syn match curryFunction "\<\(map\|mapIO\|mapIO_\|max\|maybe\|min\|mod\)\>"
syn match curryFunction "\<\(negate\|not\|notElem\|null\)\>"
syn match curryFunction "\<\(once\|or\|ord\|otherwise\)\>"
syn match curryFunction "\<\(print\|putChar\|putStr\|putStrLn\)\>"
syn match curryFunction "\<\(readFile\|repeat\|replicate\|return\|reverse\)\>"
syn match curryFunction "\<\(seq\|sequenceIO\|sequenceIO_\|show\|snd\|solveAll\|span\|splitAt\|success\)\>"
syn match curryFunction "\<\(tail\|take\|takeWhile\|try\)\>"
syn match curryFunction "\<\(uncurry\|unknown\|unlines\|unpack\|until\|unwords\|unzip\|unzip3\)\>"
syn match curryFunction "\<\(writeFile\|words\)\>"
syn match curryFunction "\<\(zip\|zip3\|zipWith\|zipWith3\)\>"


" Comments
syn keyword curryCommendTodo    TODO FIXME contained
syn match   curryLineComment    "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=curryCommendTodo
syn region  curryBlockComment   start="{-"  end="-}" contains=curryBlockComment
syn region  curryPragma         start="{-#" end="#-}"


hi def link curryModule             curryStructure
hi def link curryImport             Include
hi def link curryImportMod          curryImport
hi def link curryInfix              PreProc
hi def link curryStructure          Structure
hi def link curryStatement          Statement
hi def link curryConditional        Conditional
hi def link curryKeyword            Keyword
hi def link currySpecialChar        SpecialChar
hi def link curryTypedef            Typedef
hi def link curryVarSym             curryOperator
hi def link curryConSym             curryOperator
hi def link curryOperator           Operator
hi def link curryDelimiter          Delimiter
hi def link currySpecialCharError   Error
hi def link curryStringUnknownEsc   Error
hi def link curryString             String
hi def link curryCharacter          Character
hi def link curryNumber             Number
hi def link curryFloat              Float
hi def link curryConditional        Conditional
hi def link curryLiterateComment    curryComment
hi def link curryBlockComment       curryComment
hi def link curryLineComment        curryComment
hi def link curryComment            Comment
hi def link curryPragma             SpecialComment
hi def link curryBoolean            Boolean
hi def link curryType               Type
hi def link curryOwnType            Type
hi def link curryMaybe              curryEnumConst
hi def link curryOrdering           curryEnumConst
hi def link curryEnumConst          Constant
hi def link curryEither             Constant
hi def link curryFunction           Function

let b:current_syntax = "curry"
