set nocompatible
let $LANG='en'
"let mapleader = "\<space>"
let mapleader = ","
set lm=en

set autoread
set encoding=utf-8
"set columns=180
"set lines=45
set go=
set go+=m
set cursorline
"set cursorcolumn
syn on
syntax enable

set ruler
set showcmd
"set wildmenu
"set backspace=indent,eol,start
"set history=20
set hidden

"set laststatus=2
set number
set relativenumber
filetype on
"filetype plugin on
set shiftwidth=4
set softtabstop=4
"set et
set autoindent
set ts=4
set expandtab
"set listchars=eol:?,tab:>
"set listchars=eol:$,tab:>
set listchars=tab:>-
set list

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
set undodir=~/.config/nvim/.swap/
set backupdir=~/.config/nvim/.swap/
set directory=~/.config/nvim/.swap/

set hlsearch
set smartcase
set incsearch
set t_Co=256
set ttimeoutlen=50

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

if &term =~ "xterm\\|rxvt"
    " use an orange cursor in insert mode
    let &t_SI = "\<Esc>]12;orange\x7"
    " use a red cursor otherwise
    let &t_EI = "\<Esc>]12;red\x7"
    silent !echo -ne "\033]12;red\007"
    " reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\033]112\007"
    " use \003]12;gray\007 for gnome-terminal
endif

"===================================================================================================
" to fold js code ??? tested, NOT ok
"set foldmethod=syntax
"set foldcolumn=1
"let javaScript_fold=1
"set foldlevelstart=99
"
"
"
"===================================================================================================
" global shortcut;
nmap <F12> :tabnew \|:term<CR>
map <A-q> :q<CR>
map <F2> :checktime<CR>
nnoremap <leader>tn :tabnew<CR>
"
"
"
"===================================================================================================
call plug#begin('~/.config/nvim/.plug')
"
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"
"Plug 'rhysd/vim-clang-format'
"
"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next','do': 'bash install.sh'}
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
"Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"
"Plug 'francoiscabrol/ranger.vim'
"Plug 'rbgrouleff/bclose.vim'
"
"Plug 'sainnhe/sonokai'
"Plug 'altercation/vim-colors-solarized'
"Plug 'nlknguyen/papercolor-theme'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
"

" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" If you have nodejs and yarn
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'fioncat/vim-bufclean'

call plug#end()


"
"===================================================================================================
" gitgutter
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
"
function! GitBranch()
    let _str=gitbranch#name()
    return printf('%s', _str)
endfunction
"
"
"===================================================================================================
" lightline
let g:lightline = {
            \ 'colorscheme': 'PaperColor',
            \ 'active': {
                \   'left': [ [ 'mode', 'paste' ], [  'readonly', 'filename','gitbranch', 'modified' ] ],
                \   'right': [ [ 'lineinfo' ],[ 'percent' ],[ 'fileformat', 'fileencoding', 'filetype' ] ]
                \ },
                \ 'component_function': {
                    \   'gitbranch': 'GitBranch',
                    \   'cocstatus': 'coc#status',
                    \   'status': 'GitStatus'
                    \ },
                    \ 'mode_map': {
                        \ 'n' : 'N',
                        \ 'i' : 'I',
                        \ 'R' : 'R',
                        \ 'v' : 'V',
                        \ 'V' : 'VL',
                        \ "\<C-v>": 'VB',
                        \ 'c' : 'C',
                        \ 's' : 'S',
                        \ 'S' : 'SL',
                        \ "\<C-s>": 'SB',
                        \ 't': 'T',
                        \ },
                        \ }
"
"
"===================================================================================================
" fzf 
nmap <C-p> :Files<CR>
nmap <C-e> :Buffers<CR>
nmap <C-h> :History<CR>
"nmap <A-w> :Windows<CR>
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']
" - down / up / left / right
let g:fzf_layout = { 'down': '40%' }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }
"
" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
"
"
"===================================================================================================
" clang-format
"let g:clang_format#style_options = {
"      \ "AccessModifierOffset" : -2,
"      \ "AllowShortIfStatementsOnASingleLine" : "false",
"      \ "AlwaysBreakTemplateDeclarations" : "true",
"      \ "Standard" : "C++11"}
"
"autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
"autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
"autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
"nmap <Leader>C :ClangFormatAutoToggle<CR>
"nnoremap <silent> == :ClangFormat<CR>
"
"
"===================================================================================================
" LSP
"---------------------------------------------------------------------------------------------------
" language-client-neovim
"set runtimepath+=~/.vim/.plug/LanguageClient-neovim
"let g:LanguageClient_loadSettings = 1
"let g:LanguageClient_diagnosticsEnable = 1
"let g:LanguageClient_settingsPath = expand('~/.vim/languageclient.json')
"let g:LanguageClient_selectionUI = 'quickfix'
"let g:LanguageClient_diagnosticsList = v:null
""let g:LanguageClient_hoverPreview = 'Never'
"let g:LanguageClient_serverCommands = {
"    \ 'cpp': ['/usr/bin/clangd'],
"    \ 'c': ['/usr/bin/clangd'],
"    \ }
"
"nnoremap <silent> K :<Plug>(lcn-hover)<CR>
"nnoremap <silent> gd :<Plug>(lcn-definition)<CR>
"nnoremap <silent> <F2> :<Plug>(lcn-rename)<CR>
"
"
"
"
"
"
"---------------------------------------------------------------------------------------------------
" vim-lsp
"let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
"let g:lsp_highlights_enabled = 1
"let g:lsp_textprop_enabled = 1
"let g:lsp_highlight_references_enabled = 1
"let g:lsp_signs_enabled = 1         " enable signs
"let g:lsp_signs_error = {'text': '✗'}
"
"if executable('clangd')
"    augroup lsp_clangd
"        autocmd!
"        autocmd User lsp_setup call lsp#register_server({
"                    \ 'name': 'clangd',
"                    \ 'cmd': {server_info->['clangd']},
"                    \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp','cc'],
"                    \ })
"        autocmd FileType c setlocal omnifunc=lsp#complete
"        autocmd FileType cpp setlocal omnifunc=lsp#complete
"        autocmd FileType objc setlocal omnifunc=lsp#complete
"        autocmd FileType objcpp setlocal omnifunc=lsp#complete
"    augroup end
"endif
"
"
"
"
"==================================================================================================
" coc-nvim
" GoTo code navigation.
nmap <silent> <C-]> <Plug>(coc-definition)
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> <C-[> <Plug>(coc-implementation)
"nmap <silent> <leader>r <Plug>(coc-references)
"nmap <silent> <A-o> :CocCommand clangd.switchSourceHeader<CR>
"
" Use K to show documentation in preview window.
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction
nmap <silent> K :call <SID>show_documentation()<CR>
"
" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <leader>a  :<C-u>CocLst diagnostics<cr>
" Manage extensions.
"nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
" Formatting selected code.
xmap <C-A-l> <Plug>(coc-format-selected)
nmap <C-A-l> <Plug>(coc-format-selected)
" Search workspace symbols.
"nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>
nnoremap <nowait> <C-f> :CocSearch 
" Find symbol of current document.
map <nowait> <A-o> :CocList outline<cr>
"
"
"==================================================================================================
" fugitive
"nnoremap <nowait> <A-g> :G 
"
"
"===================================================================================================
" color scheme
"colorscheme PaperColor
colorscheme onehalfdark
set background=dark
"
"
"===================================================================================================
" ranger
" color scheme
" ranger for vim
"let g:ranger_map_keys = 0
"open ranger when vim open a directory
"let g:ranger_replace_netrw = 1 
"map <A-f> :tabnew \|:Ranger<CR>
"
"
"===================================================================================================
" coc-explorer
nnoremap <leader>e :CocCommand explorer<CR>
"
"
"===================================================================================================
" vim-bufclean
nnoremap <leader>bc :BufClean<CR>
"
"
"


