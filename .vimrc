if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


set number
set tabpagemax=250

set nocompatible

set history=1000

syntax on
syntax enable
filetype on
filetype plugin on
filetype indent on

set list
set magic
set listchars=tab:\|\ 
set mouse=a
set hlsearch
set incsearch
set ignorecase
set showmatch
set wrap

set autoindent
set smartindent

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartcase

set backspace=2
set backspace=indent,eol,start

setf vera
set splitbelow
set cursorline
set showcmd
set showmatch

set guifont=Monospace\ 10
set number relativenumber

call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
call plug#end()

set background=dark " or light if you want light mode
colorscheme gruvbox

"lang mes en

set noerrorbells

set isk+=`
set tags=./tags;
" Fold
" set nofen
" set foldenable
" set foldmethod=indent

""""""""""""TagList"""""""""""""""""
let Tlist_Auto_Update=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1

map to :TlistOpen<CR>
map tc :TlistClose<CR>
map tt :TlistToggle<CR>

"""""""""""""""Explore"""""""""""""""
"let g:explSplitVertical=0	" split horizontally
let g:explVertical=1		" split vertically
"let g:explSplitRight=0		" put the explorer window left
let g:explSplitRight=0		" put the explorer window left
let g:explStartRight=0		" put the explorer window left
let g:explWinSize=30
map :exp :Explore<CR>

"""""""""""""""""""""""""""""""""""""
"Close Pair
"""""""""""""""""""""""""""""""""""""
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>
:inoremap " ""<ESC>i
:inoremap " <c-r>=ClosePair('"')<CR>



function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf


inoremap  ,  ,<Space>

runtime macros/matchit.vim
"SyntaxHighlighting
au BufReadPost *.sv set syntax=vera
au BufReadPost *.svh set syntax=vera
au BufReadPost *.v set syntax=vera


" Let the matchit plugin know what items can be matched.
if exists("loaded_matchit")
  let b:match_ignorecase=0
  let b:match_words=
    \ '\<begin\>:\<end\>,' .
    \ '\<if\>:\<else\>,' .
    \ '\<module\>:\<endmodule\>,' .
    \ '\<class\>:\<endclass\>,' .
    \ '\<program\>:\<endprogram\>,' .
    \ '\<clocking\>:\<endclocking\>,' .
    \ '\<property\>:\<endproperty\>,' .
    \ '\<sequence\>:\<endsequence\>,' .
    \ '\<package\>:\<endpackage\>,' .
    \ '\<covergroup\>:\<endgroup\>,' .
    \ '\<primitive\>:\<endprimitive\>,' .
    \ '\<specify\>:\<endspecify\>,' .
    \ '\<generate\>:\<endgenerate\>,' .
    \ '\<interface\>:\<endinterface\>,' .
    \ '\<function\>:\<endfunction\>,' .
    \ '\<task\>:\<endtask\>,' .
    \ '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,' .
    \ '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>,' .
    \ '`ifdef\>:`else\>:`endif\>,' .
    \ '`ifndef\>:`define\>:`endif\>'
endif




if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
