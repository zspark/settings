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
syn on
syntax enable

set ruler
set showcmd
"set wildmenu
"set backspace=indent,eol,start
"set history=20

"set laststatus=2
set number
set relativenumber
filetype on
"filetype plugin on              "载入文件类型插件
set shiftwidth=4
set softtabstop=4
"set et	           "编辑时把所有制表符替换为空格
set autoindent
set ts=4
"set expandtab

set undodir=~/.vim/.swap/
set backupdir=~/.vim/.swap/
set directory=~/.vim/.swap/

set hlsearch
set smartcase
set incsearch
"colorscheme default

"++++++++++++++++++++++折叠+++++++++++++++++++++++++
" These may cause lag on ubuntu.
"set foldmethod=syntax           "设置语法折叠
"set foldcolumn=0                 "设置折叠区域宽度
"set foldenable                "开启折叠
"set foldlevel=100               "设置折叠层数 
"set guifont=DejaVu_Sans_Mono:h9

"set shell=D:\bash\
"set shell=\"C:\Program\ Files\Git\bin\bash.exe\"\

set t_Co=256
call plug#begin('~/.vim/.plug')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'altercation/vim-colors-solarized'
"Plug 'scrooloose/syntastic'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()


" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.vim/.ctags/vim-gutentags/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif



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
let g:airline_theme='cool'

colorscheme default
set background=light

