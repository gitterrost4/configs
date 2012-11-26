if &term=="screen"
    set t_Co=256
endif
if &term=="screen-256color"
    set t_Co=256
endif
let g:Imap_UsePlaceHolders = 0 "For latex-suite
syntax on
filetype plugin on
filetype indent on
set expandtab
set tabstop=4
set sw=4
set cindent
set smartindent
set autoindent
autocmd BufNewFile *.pl execute '0read !echo "\#\!/usr/bin/perl"'|2
let g:tex_flavor='latex'
set backupdir=~/tmp//
set directory=~/tmp//
set ic
set linebreak
highlight LineNr term=bold cterm=NONE ctermfg=Black ctermbg=White gui=NONE guifg=DarkGrey guibg=NONE
set number
hi Comment ctermfg=yellow
highlight Search cterm=bold ctermfg=Red ctermbg=Black guifg=Red guibg=Black
highlight Special term=bold ctermfg=176 guifg=Orange                                                                                                                                
set wildmenu
set hlsearch
set undodir=~/.vim/undodir
set undofile
set iskeyword+=:
let g:tex_isk = &isk
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
"Unnamed Register to Global register
map ,p :let @+=@@<CR>
hi PmenuSel ctermbg=7 guibg=Grey ctermfg=Black                                                                                                                                                                              
set guifont=inconsolata
set pastetoggle=<F2>
