" Language: Riml
" Maintainer: Darshan Sawardekar <darshan@sawardekar.org>
" URL: http://github.com/dsawardekar/riml.vim
" LICENSE: MIT
"
" Adapted from http://github.com/kchmck/vim-coffee-script
" Credits to original author(s): Mick Koch, et all.
"
" Notes:
"
" - Highlights Riml similar to coffeescript
" - Embedded viml beginning with :foo is highlighted with syntax/vim.vim
" - TODO: implement `syn regions` to support foldmethod=syntax
"

if exists('b:current_syntax') && b:current_syntax == 'riml'
  finish
endif

" load vim syntax for :cmd
syn include @rimlVim syntax/vim.vim

syn match rimlStatement  /\v<(return|break|continue|throw)>/ 
hi def link rimlStatement Statement

syn match rimlRepeat /\v<(for|while)>/ 
hi def link rimlRepeat Repeat

syn match rimlConditional /\v<(if|else|unless|elseif)>/ 
hi def link rimlConditional Conditional

syn match rimlException /\v<(try|catch|finally)>/ 
hi def link rimlException Exception

syn match rimlKeyword /\v<(new|super)>/ 
syn match rimlKeyword /\v<for\s+\S+\s+(in)/ contained containedin=rimlRepeat 
hi def link rimlKeyword Keyword

syn match rimlBoolean /\v<(true|false)>/ 
hi def link rimlBoolean Boolean

syn match rimlSpecialVar /\v<(self|super)>/ 
hi def link rimlSpecialVar Special

syn match rimlObject /\v\s+\u\w*/
hi link rimlObject Structure

syn match rimlConstant /\<\u[A-Z0-9_]\+\>/ 
hi link rimlConstant Constant

syn cluster rimlIdentifier contains=rimlSpecialVar,rimlObject,rimlConstant
syn cluster rimlBasicString contains=@Spell,rimlEscape
syn cluster rimlInterpString contains=@rimlBasicString,rimlInterp

" Regular strings
syn region rimlString start=/\"/ skip=/\\\\\|\\\"/ end=/\"/ contains=@rimlInterpString
syn region rimlString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=@rimlBasicString
hi def link rimlString String

syn match rimlNumber /\i\@<![-+]\?\d\+\%([eE][+-]\?\d\+\)\?/ 
syn match rimlNumber /\<0[xX]\x\+\>/ 
syn match rimlNumber /\<0[bB][01]\+\>/ 
syn match rimlNumber /\<0[oO][0-7]\+\>/ 
hi def link rimlNumber Number

syn match rimleFloat /\i\@<![-+]\?\d*\.\@<!\.\d\+\%([eE][+-]\?\d\+\)\?/
hi def link rimlFloat Float

syn match rimlObjAssign /@\?\I\i*\s*\ze::\@!/ contains=@rimlIdentifier 
hi def link rimlObjAssign Identifier

syn keyword rimlTodo TODO FIXME XXX contained
hi def link rimlTodo Todo

" from vim.vim
syn keyword rimlTodo contained	COMBAK	FIXME	TODO	XXX KLUDGE
syn cluster rimlCommentGroup	contains=rimlTodo,@Spell

syn match	rimlComment	excludenl +\s"[^\-:.%#=*].*$+lc=1	contains=@rimlCommentGroup,rimlCommentString
syn match	rimlComment	+\<endif\s\+".*$+lc=5	contains=@rimlCommentGroup,rimlCommentString
syn match	rimlComment	+\<else\s\+".*$+lc=4	contains=@rimlCommentGroup,rimlCommentString
syn region	rimlCommentString	contained oneline start='\S\s\+"'ms=e	end='"'

" TODO: feature request # line comments
syn match rimlComment /^#.*/ contains=@Spell,rimlTodo
hi def link rimlComment Comment

syn region rimlEmbed matchgroup=rimlEmbedDelim start=/^\s*:/ skip=/\\\\\|\\`/ end=/\n/ contains=@rimlVim
hi def link rimlEmbedDelim Delimiter

syn region rimlInterp matchgroup=rimlInterpDelim start=/#{/ end=/}/ contained contains=@rimlAll
hi def link rimlInterpDelim PreProc

syn match rimlEscape /\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\./ contained 
hi def link rimlEscape SpecialChar

syn region rimlRegex start=/\%(\%()\|\i\@<!\d\)\s*\|\i\)\@<!\/=\@!\s\@!/
\ skip=/\[[^\]]\{-}\/[^\]]\{-}\]/
\ end=/\/[gimy]\{,4}\d\@!/
\ oneline contains=@rimlBasicString
hi def link rimlRegex String

syn region rimlHeredoc start=/<<EOS/ end=/EOS/ contains=@rimlInterpString fold
syn region rimlHeredoc start=/'''/ end=/'''/ contains=@rimlBasicString fold
hi def link rimlHeredoc String

syn region rimlCurlies matchgroup=rimlCurly start=/{/ end=/}/ contains=@rimlAll
syn region rimlBrackets matchgroup=rimlBracket start=/\[/ end=/\]/ contains=@rimlAll
syn region rimlParens matchgroup=rimlParen start=/(/ end=/)/ contains=@rimlAll

" object oriented keywords
syn keyword rimlClass class
hi def link rimlClass Define

" methods
syn keyword rimlMethod defm
hi def link rimlMethod Function

syn keyword rimlFunction def
hi def link rimlFunction Function

syn cluster rimlAll contains=rimlStatement,rimlRepeat,rimlConditional,
\ rimlException,rimlKeyword,rimlOperator,
\ rimlExtendedOp,rimlSpecialOp,rimlBoolean,
\ rimlGlobal,rimlSpecialVar,rimlSpecialIdent,
\ rimlObject,rimlConstant,rimlString,
\ rimlNumber,rimlFloat,rimlReservedError,
\ rimlObjAssign,rimlComment,rimlBlockComment,
\ rimlEmbed,rimlRegex,rimlHeregex,
\ rimlHeredoc,rimlSpaceError,
\ rimlSemicolonError,rimlDotAccess,
\ rimlProtoAccess,rimlCurlies,rimlBrackets,
\ rimlParens

let b:current_syntax = 'riml'
