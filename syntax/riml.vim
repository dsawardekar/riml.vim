" Language: Riml {{{1
" Maintainer: Darshan Sawardekar <darshan@sawardekar.org>
" URL: http://github.com/dsawardekar/riml.vim
" LICENSE: MIT
"
" Adapted from 
" - ruby.vim
" - vim.vim
" - vim-coffee-script
"
" Credits to original author(s): Mick Koch, et all.
"
" Notes:
"
" - Set g:riml_no_expensive - to disable syn fromstart
" - Set g:riml_no_default_styles - to disable default styles

" ifdef {{{1
if exists('b:current_syntax') && b:current_syntax == 'riml'
  finish
endif

" rimlNumber {{{1
" cluster
" contains: rimlInteger, rimlFloat

" integers
syn match rimlInteger	"\<\d\+\%(\.\d\+\%([eE][+-]\=\d\+\)\=\)\=" display
syn match rimlInteger	"-\d\+\%(\.\d\+\%([eE][+-]\=\d\+\)\=\)\="  display
syn match rimlInteger	"\<0[xX]\x\+"                              display
syn match rimlInteger	"#\x\{6}"                                  display

" floats
syn match rimlFloat /\i\@<![-+]\?\d*\.\@<!\.\d\+\%([eE][+-]\?\d\+\)\?/ display

" cluster for rimlNumber
syn cluster rimlNumber contains=rimlInteger,rimlFloat

" rimlVariable {{{1
" cluster
" contains: rimlUnscopedVar, rimlVar, rimlFBVar

" variable types
syn match rimlUnscopedVar "\<\h[a-zA-Z0-9#_]*\>"
syn match rimlScopedVar	        "\<[bwglsav]:[a-zA-Z0-9#_]*\>"
syn match rimlPsuedoVariable "\<\%\(super\|self\)\>[?!]\@!"
syn match rimlConstant /\<\u[A-Z0-9_]\+\>/ 

" cluster for rimlVariable
syn cluster rimlVariable contains=rimlUnscopedVar,rimlScopedVar,rimlFBVar,rimlPsuedoVariable,rimlConstant

" rimlIdentifier {{{1
" cluster
" contains: rimlVariable, rimlObject

" objects
syn match rimlObject /\v\s+([bwglsav]:)?\u\w*/

" cluster for rimlIdentifier
syn cluster rimlIdentifier contains=rimlVariable,rimlObject

" rimlKeyword {{{1
" cluster
" contains: rimlBoolean, rimlSpecialScope

" booleans
syn keyword rimlBoolean true false
syn match   rimlControl	"\<\%(and\|break\|in\|continue\|not\|or\|new\|return\)\>[?!]\@!"
syn keyword rimlInclude riml_include riml_source
syn keyword rimlBuiltins echo echomsg

" functions keywords {{{1
syn keyword rimlFuncName contained	abs and argidx atan browsedir bufloaded bufwinnr call char2nr col complete_check cos cscope_connection delete diff_hlID eval exists expr8 filereadable finddir floor fnamemodify foldlevel foreground get getchar getcmdpos getfontname getftime getloclist getpos getregtype getwinposx glob has_key histadd histnr hostname index inputlist inputsecret isdirectory join libcall line2byte log map match matchdelete matchstr mkdir nextnonblank pathshorten printf pyeval reltime remote_foreground remote_read remove repeat reverse search searchpair searchpos serverlist setcmdpos setloclist setpos setreg settabwinvar shellescape simplify sinh soundfold spellsuggest sqrt str2nr strdisplaywidth stridx strlen strridx strwidth substitute synID synIDtrans system tabpagenr tagfiles tan tempname toupper trunc undofile values visualmode wincol winline winrestcmd winsaveview writefile
syn keyword rimlFuncName contained	acos append argv atan2 bufexists bufname byte2line ceil cindent complete confirm cosh cursor did_filetype empty eventhandler exp extend filewritable findfile fmod foldclosed foldtext function getbufline getcharmod getcmdtype getfperm getftype getmatches getqflist gettabvar getwinposy globpath haslocaldir histdel hlexists iconv input inputrestore insert islocked keys libcallnr lispindent log10 maparg matchadd matchend max mode nr2char pow pumvisible range reltimestr remote_peek remote_send rename resolve round searchdecl searchpairpos server2client setbufvar setline setmatches setqflist settabvar setwinvar shiftwidth sin sort spellbadword split str2float strchars strftime string strpart strtrans submatch synconcealed synIDattr synstack tabpagebuflist tabpagewinnr taglist tanh tolower tr type undotree virtcol winbufnr winheight winnr winrestview winwidth xor
syn keyword rimlFuncName contained	add argc asin browse buflisted bufnr byteidx changenr clearmatches complete_add copy count deepcopy diff_filler escape executable expand feedkeys filter float2nr fnameescape foldclosedend foldtextresult garbagecollect getbufvar getcmdline getcwd getfsize getline getpid getreg gettabwinvar getwinvar has hasmapto histget hlID indent inputdialog inputsave invert items len line localtime luaeval mapcheck matcharg matchlist min mzeval or prevnonblank py3eval readfile remote_expr 

" cluster for rimlKeyword
syn cluster rimlKeyword contains=rimlBoolean,rimlControl,rimlInclude,rimlBuiltins,rimlFuncName

" rimlExpression {{{1
" cluster
" contains: rimlKeyword, rimlIdentifier, rimlNumber
syn cluster rimlExpression contains=rimlKeyword,rimlIdentifier,rimlNumber

" rimlString {{{1
" cluster 
" contains: rimlBasicString, rimlInterpolatedString, rimlHeredoc

" escapes
syn match rimlQuoteEscape  "\\[\\']"											    contained display
syn match rimlEscape /\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\./ contained 

" rimlBasicString
" delimiter: single quotes
" contains: rimlQuoteEscape, rimlEscape
syn region rimlBasicString matchgroup=rimlStringDelimiter start="'" end="'" skip='\\|"' contains=rimlQuoteEscape,rimlEscape,@Spell

" rimlInterpolatedString
" delimiter: double quotes
" contains: rimlInterpolation, rimlQuoteEscape, rimlEscape, rimlExpression
syn region rimlInterpolation matchgroup=rimlInterpolationDelimiter start='#{' end='}' display contained contains=@rimlExpression,rimlParen,rimlBrace
syn region rimlInterpolatedString matchgroup=rimlStringDelimiter start='"' end='"' skip='\\|"\'' contains=rimlEscape,rimlQuoteEscape,rimlInterpolation,@Spell

" rimlHeredoc
" delimiter: <<EOS ... ^EOS
" contains: rimlInterpolation, rimlQuoteEscape, rimlEscape, rimlExpression
syn region rimlHeredoc matchgroup=rimlStringDelimiter start='\v<<EOS' end='EOS' contains=rimlInterpolation,rimlQuoteEscape,rimlEscape,@Spell fold

" rimlRegexp
syn region rimlRegexp start=/\%(\%()\|\i\@<!\d\)\s*\|\i\)\@<!\/=\@!\s\@!/
\ skip=/\[[^\]]\{-}\/[^\]]\{-}\]/
\ end=/\/[gimy]\{,4}\d\@!/
\ oneline contains=@rimlBasicString

" blocks {{{1
" base
syn match  rimlMethodDeclaration   "[^[:space:];#(]\+"	 contained contains=rimlConstant,rimlBoolean,rimlVariable
syn match  rimlClassDeclaration    "[^[:space:];#<]\+"	 contained contains=rimlConstant,rimlOperator
syn match  rimlFunction "\<[_[:alpha:]][_[:alnum:]]*[?!=]\=[[:alnum:]_.:?!=]\@!" contained containedin=rimlMethodDeclaration
syn cluster rimlDeclaration contains=rimlMethodDeclaration,rimlClassDeclaration,rimlFunction

  " top level blocks {{{2
  syn match  rimlDefine "\v<(defm|def)>"    nextgroup=rimlMethodDeclaration skipwhite skipnl
  syn match  rimlClass	"\v<class>"  nextgroup=rimlClassDeclaration  skipwhite skipnl

  syn region rimlMethodBlock start="\v<(def|defm)>"	matchgroup=rimlDefine end="\%(\<def\_s\+\)\@<!\<end\>" contains=ALLBUT,@rimlNotTop fold
  syn region rimlBlock	     start="\v<class>"	matchgroup=rimlClass  end="\<end\>"		       contains=ALLBUT,@rimlNotTop fold
  syn region rimlBlock	     start="\v<module>" matchgroup=rimlModule end="\<end\>"		       contains=ALLBUT,@rimlNotTop fold

  " conditionals {{{2
  syn match rimlConditionalModifier '\v<(if|unless)>' display
  syn match rimlConditional '\v<(then|else|elseif)>' contained containedin=rimlConditionalExpression
  syn region rimlConditionalExpression matchgroup=rimlConditional start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+=-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![?!]\)\s*\)\@<=\%(if\|unless\)\>" end="\%(\%(\%(\.\@<!\.\)\|::\)\s*\)\@<!\<end\>" contains=ALLBUT,@rimlNotTop fold

  " exceptions {{{2
  syn match rimlExceptionalModifier '\v<(try)\s*$>' display
  syn match rimlExceptional '\v<(catch)>' containedin=rimlMethodBlock
  syn region rimlExceptionalExpression matchgroup=rimlExceptional start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+=-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![?!]\)\s*\)\@<=\%(try\|catch\)\>" end="\<end\>" contains=ALLBUT,@rimlNotTop fold

  " loops {{{2
  syn match rimlRepeatModifier	     "\<\%(for\|while\)\>" display
  syn region rimlRepeatExpression start="\<\(for\|while\)\>[?!]\@!" matchgroup=rimlRepeat end="\<end\>" contains=ALLBUT,@rimlNotTop fold

  " misc blocks {{{2
  syn region rimlBrace matchgroup=rimlBraceDelimiter start=/{/ end=/}/ contains=ALLBUT,@rimlNotTop fold

" embedded viml
syn region rimlEmbed matchgroup=rimlEmbedDelimiter start=/^\s*:/ skip=/\\\\\|\\`/ end=/\n/ contains=@rimlVim
syn include @rimlVim syntax/vim.vim

" not top {{{1
syn cluster rimlNotTop contains=@rimlDeclaration,@rimlString,@rimlRegexp,@rimlExpression,rimlConditional,rimlExceptional,rimlTodo

" comments {{{1
syn keyword rimlTodo contained	COMBAK	FIXME	TODO	XXX KLUDGE
syn match	rimlComment '\v(^\s*)".*$' display
syn match rimlComment '\v(^\s*)#.*' contains=@Spell,rimlTodo

" highlighting {{{1
" comments
hi def link rimlComment Comment

" numbers
hi def link rimlInteger Number 
hi def link rimlFloat Float

" keywords
hi def link rimlBoolean Boolean
hi def link rimlControl Statement
hi def link rimlInclude PreProc
hi def link rimlBuiltins Function
hi def link rimlFuncName Function

" identifiers
"hi def link rimlUnscopedVar Identifier
hi def link rimlScopedVar Constant
hi def link rimlObject Type
hi def link rimlPsuedoVariable Special

" strings
hi def link rimlQuoteEscape Special
hi def link rimlEscape Special
hi def link rimlInterpolationDelimiter Delimiter
hi def link rimlStringDelimiter Delimiter
hi def link rimlEmbedDelimiter Delimiter
hi def link rimlBraceDelimiter Delimiter

hi def link rimlBasicString String
hi def link rimlHeredoc String
hi def link rimlInterpolatedString String
hi def link rimlString String

" regexp
hi def link rimlRegexp String

" exceptions
hi def link rimlExceptionalModifier rimlConditional
hi def link rimlExceptional rimlConditional

" conditionals
hi def link rimlConditionalModifier rimlConditional
hi def link rimlConditional Conditional

" loops
hi def link rimlRepeatModifier Repeat
hi def link rimlRepeat Repeat

" classes
hi def link rimlDefine Define
hi def link rimlClass Define
hi def link rimlClassDeclaration Type

" function blocks
hi def link rimlFunction Identifier

" default styles {{{1
if !exists('g:riml_no_default_styles')
  hi Define gui=bold term=bold cterm=bold
end

let b:current_syntax = 'riml'

if !exists('g:riml_no_expensive')
  syn sync fromstart
endif
