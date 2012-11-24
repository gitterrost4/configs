set nocindent
set timeoutlen=2000
map  <ESC>:w<CR>:!pdflatex %; evince %:r.pdf&sleep 0.2;wmctrl -a tilda<CR><CR>
inoremap  <ESC>:w<CR>:!pdflatex %; evince %:r.pdf&sleep 0.2;wmctrl -a tilda<CR>a
inoremap R<Tab> \mathds R
inoremap N<Tab> \mathds N
inoremap Z<Tab> \mathds Z
inoremap C<Tab> \mathds C
inoremap Q<Tab> \mathds Q
inoremap p<Tab> \varphi
inoremap cases<Tab> \begin{cases}<CR>\end{cases}<Up>
inoremap enum<Tab> \begin{enumerate}<CR>\item <CR><Up><Up><Esc>^<Down><Down>i\end{enumerate}<Up>
inoremap item<Tab> \begin{itemize}<CR>\item <CR><Up><Up><Esc>^<Down><Down>i\end{itemize}<Up>
inoremap matrix<Tab> \left(\begin{array}{ccc}<CR>\end{array}\right)<Esc>O
inoremap align<Tab> \begin{align*}<CR>\end{align*}<Esc>O
inoremap verb<Tab> \begin{verbatim}<CR>\end{verbatim}<Esc>O
inoremap algin<Tab> \begin{align*}<CR>\end{align*}<Esc>O
inoremap def<Tab> \begin{def2}<CR>\end{def2}<Esc>O
inoremap beh<Tab> \begin{beh}<CR>\end{beh}<Esc>O
inoremap proof<Tab> \begin{proof}<CR>\end{proof}<Esc>O
inoremap hinw<Tab> \begin{hinw}<CR>\end{hinw}<Esc>O
inoremap satz<Tab> \begin{satz}<CR>\end{satz}<Esc>O
inoremap folg<Tab> \begin{folg}<CR>\end{folg}<Esc>O
inoremap folg*<Tab> \begin{folg*}<CR>\end{folg*}<Esc>O
inoremap kor<Tab> \begin{kor}<CR>\end{kor}<Esc>O
inoremap kor*<Tab> \begin{kor*}<CR>\end{kor*}<Esc>O
inoremap hilf<Tab> \begin{hilf}<CR>\end{hilf}<Esc>O
inoremap hilf*<Tab> \begin{hilf*}<CR>\end{hilf*}<Esc>O
inoremap lem<Tab> \begin{lem}<CR>\end{lem}<Esc>O
inoremap bem<Tab> \begin{bem}<CR>\end{bem}<Esc>O
inoremap beisp<Tab> \begin{beisp}<CR>\end{beisp}<Esc>O
inoremap def*<Tab> \begin{def2*}<CR>\end{def2*}<Esc>O
inoremap beh*<Tab> \begin{beh*}<CR>\end{beh*}<Esc>O
inoremap hinw*<Tab> \begin{hinw*}<CR>\end{hinw*}<Esc>O
inoremap satz*<Tab> \begin{satz*}<CR>\end{satz*}<Esc>O
inoremap lem*<Tab> \begin{lem*}<CR>\end{lem*}<Esc>O
inoremap bem*<Tab> \begin{bem*}<CR>\end{bem*}<Esc>O
inoremap beisp*<Tab> \begin{beisp*}<CR>\end{beisp*}<Esc>O
inoremap vor<Tab> \begin{voraus*}<CR>\end{voraus*}<Esc>O
inoremap graph<Tab> Sei $\Gamma=\Gamma(E,K)$ ein Graph. 
inoremap ... \ldots
inoremap \frac \frac{}{}<Left><Left><Left>
inoremap ae<Tab> "a
inoremap ue<Tab> "u
inoremap oe<Tab> "o
inoremap Ae<Tab> "A
inoremap Oe<Tab> "O
inoremap Ue<Tab> "U
inoremap ss<Tab> "s
inoremap l<Tab> Letzte Woche:\begin{itemize}<CR>
inoremap d<Tab> Diese Woche:\begin{itemize}<CR>
inoremap e<Tab> \end{itemize}
let g:Tex_AutoFolding=0
" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

function! Checkmathmode(math, nomath)
  let i=0
  if synIDattr(synID(line('.'), col('.')-1, 1), "name")=~"texStatement"
    while(synIDattr(synID(line('.'), col('.')-i-1, 1), "name")=~"texStatement")
      let i=i+1
    endwhile
    if synIDattr(synID(line('.'), col('.')-i-1, 1), "name")=~"texMath"
      return a:math
    endif
  endif
  if synIDattr(synID(line('.'), col('.')-i-1, 1), "name")=~"texMath"
    return a:math 
  endif
  if synIDattr(synID(line('.'), col('.')-i, 1), "name")=~ "texMath" 
    return a:math 
  endif
  if synIDattr(synID(line('.'), col('.')-i-1, 1), "name")=~"Delimiter" 
    if synIDattr(synID(line('.'), col('.')-i-2, 1), "name")=~"Delimiter" 
      if synIDattr(synID(line('.'), col('.')-i-3, 1), "name")!~"texMath" 
        return a:math 
      endif
      return a:nomath
    endif 
    if synIDattr(synID(line('.'), col('.')-i-2, 1), "name")!~"texMath" 
      return a:math 
    endif
    return a:nomath
  endif
  return a:nomath
endfunction

"inoremap <expr> ( Checkmathmode("\\left(","(")
"inoremap <expr> ) Checkmathmode("\\right)",")")
inoremap (<Tab> \left(
inoremap )<Tab> \right)
inoremap [<Tab> \left[
inoremap ]<Tab> \right]
inoremap {<Tab> \left\{
inoremap }<Tab> \right\}
inoremap mc<Tab> \mathcal 
inoremap gb<Tab> gr"une B"alle
inoremap ^<Tab> ^{-1}
inoremap B<Tab> \mathcal B_0(\mathds R^d)
inoremap FK<Tab> ^{\FK}
inoremap FG<Tab> ^{\FG}
inoremap nm<Tab> \trianglelefteq
"call IMAP('((','((','tex')
"call IMAP('()','()','tex')
"call IMAP('[[','[[','tex')
"call IMAP('[]','[]','tex')
"call IMAP('{{','{{','tex')
"call IMAP('{}','{}','tex')
"call IMAP('$$','$$','tex')
inoremap fu<Tab> \mbox{ fast "uberall}
"TEs t: AUTOSAVE

