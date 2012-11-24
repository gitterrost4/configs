let g:Imap_UsePlaceHolders =0
syntax on
filetype plugin on
set cindent
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
set backupdir=~/tmp//
set directory=~/tmp//
let g:netrw_keepdir= 0
highlight link netrwDir Operator
highlight link netrwComment Constant
"highlight link netrwExe Function
let g:netrw_localcopycmd="cp -r"
let g:netrw_local_rmdir="rm -r"
let g:netrw_liststyle=1
let g:netrw_hide=1
let g:netrw_list_hide="\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
let g:netrw_altv=1
let g:netrw_maxfilenamelen=64
let dspace=system('discspace')
hi Comment ctermfg=yellow
set ic
set number
hi LineNr ctermbg=White ctermfg=Black
highlight Search cterm=bold ctermfg=Red ctermbg=Black guifg=Red guibg=Black
highlight Special term=bold ctermfg=176 guifg=Orange                                                                                                                                
set wildmenu
set hlsearch
set undodir=~/.vim/undodir
set undofile
set iskeyword+=:
let g:tex_isk = &isk
