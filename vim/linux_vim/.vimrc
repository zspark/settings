
set nocompatible
let $LANG='en'
set lm=en

set encoding=utf-8
set columns=120
set lines=35
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

set laststatus=2
set number
set relativenumber
set shiftwidth=2
set softtabstop=2
set autoindent
set ts=2
set expandtab

set undodir=~/.vim_swap/undo
set backupdir=~/.vim_swap/backup
set directory=~/.vim_swap/

set hlsearch
set smartcase
set incsearch

"set guifont=DejaVu_Sans_Mono:h9

"set shell=D:\bash\
"set shell=\"C:\Program\ Files\Git\bin\bash.exe\"\

call plug#begin()
Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'altercation/vim-colors-solarized'
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

let g:airline_powerline_fonts = 1

let g:solarized_termcolors=256
if has('gui_running')
  set background=light
else
  set background=dark
endif
colorscheme solarized
