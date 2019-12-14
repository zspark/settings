set nocompatible
let $LANG='en'
set lm=en

set encoding=utf-8
set columns=180
set lines=45
set go=
set go+=m
set cursorline
set cursorcolumn
set t_Co=256
syn on
syntax enable

set ruler
set showcmd
set wildmenu
set backspace=indent,eol,start
set history=20

"set laststatus=2
set number
set relativenumber
filetype on
filetype plugin on              "载入文件类型插件
set shiftwidth=2
set softtabstop=2
set et	           "编辑时把所有制表符替换为空格
set autoindent
set ts=2
set expandtab

set undodir=~/.vim/.swap/
set backupdir=~/.vim/.swap/
set directory=~/.vim/.swap/

set hlsearch
set smartcase
set incsearch
"colorscheme default

"++++++++++++++++++++++折叠+++++++++++++++++++++++++
set foldenable                "开启折叠
set foldmethod=syntax           "设置语法折叠
set foldcolumn=0                 "设置折叠区域宽度
set foldlevel=100               "设置折叠层数

"set guifont=DejaVu_Sans_Mono:h9

"set shell=D:\bash\
"set shell=\"C:\Program\ Files\Git\bin\bash.exe\"\

call plug#begin('~/.vim/.plug')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'altercation/vim-colors-solarized'
"Plug 'scrooloose/syntastic'
call plug#end()


map <F2> :silent! NERDTreeToggle<CR>
let NERDTreeWinPos="left"   "将窗口显示在右边
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeDirArrowCollapsible = '-'

let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_use_caching=1
let g:ctrlp_working_path_mode = ""


let g:airline_powerline_fonts = 0
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
let g:airline_theme='light'
