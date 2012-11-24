map ,l :!dphp -l %<CR>
map ,L :tabdo !dphp -l %<CR>
inoremap for<tab> for($i = 0; $i<; $i++){<Left><Left><Left><Left><Left><Left><Left><Left>
set dictionary+=~/workspace/hal2/db/create.sql
set complete+=k
"map ,f :silent lvimgrep /\<function\s\w*\s*(/ %<CR> :vert lopen <CR>50<C-W>>:setlocal modifiable<CR>:%s/[a-zA-Z0-9_\/]*\///<CR>:%s/function\s*\(\w*\)\s*.*$/\1/<CR>:setlocal nomodifiable<CR>:setlocal nomodified<CR>
"
"vmap ,f J0"fd$dd:let@f="<?php ".@f." ?>"<CR>:let @f=system("echo ".shellescape(@f)."\|phpCB\|sed \"s/<?php\\s*//g\"\| sed \"s/?>.*//\"")<CR>"fP=`]

"vmap ,f "fd:let@f="<?php ".@f." ?>"<CR>:let @f=system("echo ".shellescape(@f)."\|phpCB\|sed \"s/<?php\\s*//g\"\| sed \"s/?>.*//\"")<CR>"fP:'[,']s/^\s*\\//<CR>'[=']

vmap ,f :w! /tmp/phpcb<CR>:silent !sed '1 i <?php' /tmp/phpcb > /tmp/phpcb2<CR>:silent !echo "?>" >> /tmp/phpcb2<CR>:redraw!<CR>:let @f=system("phpCB /tmp/phpcb2\|sed \"s/<?php//\"\|sed \"s/?>//\"\|sed \"1 d\"\|sed \"$ d\"")<CR>`<V`>"fP=`]
nmap ,f V,f
"if @c=="dev"
"    autocmd BufReadPost,FileReadPost version.inc |
"    map <F5> 1G/HAL2_VERSION<CR>f.<C-a>f.<Right>ct'0<ESC>0f'<Right>"vyt':let @v="V ".@v." FEATURE: "<CR>:x|
"    map <F6> 1G/HAL2_VERSION<CR>2f.<C-a>0f'<Right>"vyt':let @v="V ".@v." BUGFIX: "<CR>:x
"else
"    autocmd BufReadPost,FileReadPost version.inc |
"    map <F5> 1G/HAL2_VERSION<CR>f.<C-a>f.<Right>ct'0<ESC>:x|
"    map <F6> 1G/HAL2_VERSION<CR>2f.<C-a>:x
"endif
set encoding=latin1
