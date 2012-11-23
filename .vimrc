if &term=="screen"
    set t_Co=256
endif
if &term=="screen-256color"
    set t_Co=256
endif
syntax on
filetype plugin on
filetype indent on
set expandtab
set tabstop=4
set sw=4
set autoindent
"set autochdir
autocmd FileType php noremap <C-4> :!$HOME/bin/php -l %<CR>
autocmd BufNewFile *.pl execute '0read !echo "\#\!/usr/bin/perl"'|2
"map ,f :TlistToggle<CR>
filetype plugin on
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
com FL tabnew ~/etc/filelist
com PAdd silent execute "!prj padd %" | redraw!
com PClear silent execute "!prj pclear" | redraw!
hi Comment ctermfg=yellow
"if has("gui_running")
"GUI is running or is about to start.
"   " Maximize gvim window.
"  set lines=101 columns=200
"endif
let g:netrw_liststyle=1
let g:netrw_list_hide="\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
let g:netrw_keepdir=0
let g:netrw_altv=1
"<Plug>SQLSetType
" mysql
let g:sql_type_default = 'mysql'
set ic
set linebreak
highlight LineNr term=bold cterm=NONE ctermfg=Black ctermbg=White gui=NONE guifg=DarkGrey guibg=NONE
set number
set undodir=~/.vim/undodir
set undofile
set hlsearch
set wildmenu
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
"inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
set tabpagemax=50
"Unnamed Register to Global register
map ,p :let @+=@@<CR>
set encoding=latin1
"set path+=config,funktionen,
let g:EclimPhpHtmlValidate=0
hi PmenuSel ctermbg=7 guibg=Grey ctermfg=Black                                                                                                                                                                              
map ,r :LocateFile<CR>
let g:EclimLocateFileDefaultAction="tabnew"
set runtimepath+=~/.vim/tagbar
hi Search cterm=bold ctermbg=black guibg=black ctermfg=red guifg=red
map <F8> :TagbarOpenAutoClose<CR>:lopen<CR>
let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_foldlevel = 0
let g:tagbar_compact = 1
let g:tagbar_autoshowtag = 0
map <F3> :PhpSearchContext<CR>
set guifont=inconsolata
set pastetoggle=<F2>

