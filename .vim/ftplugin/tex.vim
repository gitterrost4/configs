set nocindent
set timeoutlen=2000
"map  <ESC>:w<CR>:!compilelatex % >%:r.extralog;<CR><CR>
map  <ESC>:w<CR>:!compilelatex %;<CR><CR>
map  <ESC>:!mupdf %:r.pdf>/dev/null 2>&1 &<CR><CR>
"inoremap  <ESC>:w<CR>:!compilelatex % >%:r.extralog;<CR>a
inoremap  <ESC>:w<CR>:!compilelatex %;<CR>a
inoremap  <ESC>:!mupdf %:r.pdf>/dev/null 2>&1 &<CR>a
"inoremap R<Tab> \mathds R
"inoremap K<Tab> \mathds K
"inoremap X<Tab> \mathds X
"inoremap N<Tab> \mathds N
"inoremap Z<Tab> \mathds Z
"inoremap C<Tab> \mathds C
"inoremap Q<Tab> \mathds Q
"inoremap p<Tab> \varphi
"inoremap e<Tab> \varepsilon
"inoremap u<Tab> \utilde{}<Left>
"inoremap cases<Tab> \begin{cases}<CR>\end{cases}<Up>
"inoremap enum<Tab> \begin{enumerate}<CR>\item <CR><Up><Up><Esc>^<Down><Down>i\end{enumerate}<Up>
"inoremap enumi<Tab> \begin{enumerate}[(i)]<CR>\item <CR><Up><Up><Esc>^<Down><Down>i\end{enumerate}<Up>
"inoremap enuma<Tab> \begin{enumerate}[(a)]<CR>\item <CR><Up><Up><Esc>^<Down><Down>i\end{enumerate}<Up>
"inoremap enum1<Tab> \begin{enumerate}[(1)]<CR>\item <CR><Up><Up><Esc>^<Down><Down>i\end{enumerate}<Up>
"inoremap item<Tab> \begin{itemize}<CR>\item <CR><Up><Up><Esc>^<Down><Down>i\end{itemize}<Up>
"inoremap matrix<Tab> \left(\begin{array}{ccc}<CR>\end{array}\right)<Esc>O
"inoremap align<Tab> \begin{align*}<CR>\end{align*}<Esc>O
"inoremap verb<Tab> \begin{verbatim}<CR>\end{verbatim}<Esc>O
"inoremap algin<Tab> \begin{align*}<CR>\end{align*}<Esc>O
"inoremap beh<Tab> \begin{beh}<CR>\end{beh}<Esc>O
"inoremap proof<Tab> \begin{proof}<CR>\end{proof}<Esc>O
"inoremap folg*<Tab> \begin{folg*}<CR>\end{folg*}<Esc>O
"inoremap theo*<Tab> \begin{theo*}<CR>\end{theo*}<Esc>O
"inoremap kor*<Tab> \begin{kor*}<CR>\end{kor*}<Esc>O
"inoremap hilf*<Tab> \begin{hilf*}<CR>\end{hilf*}<Esc>O
inoremap <C-l> <Esc>?\\label<CR>yy``P$<Left><C-a><Down>A
"inoremap lem<Tab> \begin{lem}<CR>\end{lem}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap bem<Tab> \begin{bem}<CR>\end{bem}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap kor<Tab> \begin{kor}<CR>\end{kor}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap theo<Tab> \begin{theo}<CR>\end{theo}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap folg<Tab> \begin{folg}<CR>\end{folg}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap prop<Tab> \begin{prop}<CR>\end{prop}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap satz<Tab> \begin{satz}<CR>\end{satz}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap schritt<Tab> \begin{schritt}<CR>\end{schritt}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap hinw<Tab> \begin{hinw}<CR>\end{hinw}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap def<Tab> \begin{def2}<CR>\end{def2}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap hilf<Tab> \begin{hilf}<CR>\end{hilf}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap beisp<Tab> \begin{beisp}<CR>\end{beisp}<Esc>?\\label<CR>yy``P$<Left><C-a>:noh<CR>o
"inoremap frame<Tab> \begin{frame}<CR>\end{frame}<Esc>O
"inoremap def*<Tab> \begin{def2*}<CR>\end{def2*}<Esc>O
"inoremap beh*<Tab> \begin{beh*}<CR>\end{beh*}<Esc>O
"inoremap hinw*<Tab> \begin{hinw*}<CR>\end{hinw*}<Esc>O
"inoremap satz*<Tab> \begin{satz*}<CR>\end{satz*}<Esc>O
"inoremap lem*<Tab> \begin{lem*}<CR>\end{lem*}<Esc>O
"inoremap bem*<Tab> \begin{bem*}<CR>\end{bem*}<Esc>O
"inoremap beisp*<Tab> \begin{beisp*}<CR>\end{beisp*}<Esc>O
"inoremap vor<Tab> \begin{voraus*}<CR>\end{voraus*}<Esc>O
"inoremap exer<Tab> \begin{exer*}<CR>\end{exer*}<Esc>O
"inoremap prop*<Tab> \begin{prop*}<CR>\end{prop*}<Esc>O
inoremap ... \ldots
"inoremap \frac<Tab> \frac{}{}<Left><Left><Left>
"inoremap t<Tab> \tilde 
"inoremap r<Tab> \reff{<Esc>:inoremap <lt>Space> }<lt>Esc>:iunmap <lt>lt>Space><lt>CR>a <CR>a
"inoremap r<Tab> \reff{
com! Vorl tabnew ~/Dropbox/Uni/Tex-Vorlagen/vorlage.sty
let g:Tex_AutoFolding=0
" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!

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
"inoremap (<Tab> \left(
"inoremap )<Tab> \right)
"inoremap <<Tab> \left<
"inoremap ><Tab> \right>
"inoremap [<Tab> \left[
"inoremap ]<Tab> \right]
"inoremap {<Tab> \left\{
"inoremap }<Tab> \right\}
"inoremap <Bar><Tab> \middle<Bar>
"inoremap mc<Tab> \mathcal 
"inoremap ms<Tab> \mathscr 
"inoremap b<Tab> \textbf{}<Left>
vnoremap ,b di\textbf{<Esc>pa}<Esc>
"inoremap ol<Tab> \overline 
"inoremap mf<Tab> \mathfrak 
"inoremap ^<Tab> ^{-1}
"inoremap nm<Tab> \trianglelefteq 
"inoremap iff<Tab> if and only if 
"inoremap wrt<Tab> with respect to
"inoremap on<Tab> \operatorname
"call IMAP('((','((','tex')
"call IMAP('()','()','tex')
"call IMAP('[[','[[','tex')
"call IMAP('[]','[]','tex')
"call IMAP('{{','{{','tex')
"call IMAP('{}','{}','tex')
"call IMAP('$$','$$','tex')
"inoremap fu<Tab> \mbox{ fast "uberall}
"inoremap l<Tab> \limits
"TEs t: AUTOSAVE
