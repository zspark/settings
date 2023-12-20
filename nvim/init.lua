local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local opt = vim.opt  -- to set options
local g = vim.g
local fn = vim.fn
local api = vim.api
--
--
--
--
g.nocompatible=true
g.autoread=true
g.encoding="utf-8"
g.on=true
g.enable=true
g.ruler=true
g.showcmd=true
g.showmatch=true
g.mapleader = ","
g.nobackup=true       --"no backup files
g.nowritebackup=true  --"only in case you don't want a backup file while editing
g.noswapfile=true     --"no swap files
g.undodir="~/.config/nvim/.swap/"
g.backupdir="~/.config/nvim/.swap/"
g.directory="~/.config/nvim/.swap/"
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.expandtab = true                -- Use spaces instead of tabs
opt.autoindent=true
opt.ts=4
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 4                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 4                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.cursorline = true
opt.hlsearch=true
opt.incsearch=true
opt.ttimeoutlen=50
opt.updatetime=100
opt.wrap=true
opt.linebreak=true
--
--
--
--
--
--
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end
cmd [[packadd packer.nvim]]
--
--
--
--
local _packer=require('packer');
_packer.init({
  git={
    depth = 1, -- Git clone depth
    clone_timeout = 60, -- Timeout, in seconds, for git clones
    --default_url_format = 'https://gitee.com/%s' -- Lua format string used for "aaa/bbb" style plugins
  }
})
_packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-tree/nvim-web-devicons"
  use "nvim-lua/plenary.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use { "nvim-telescope/telescope.nvim", requires = { {"nvim-lua/plenary.nvim"} }, }
  use "EdenEast/nightfox.nvim"
  use "williamboman/mason.nvim"
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        options = {
          theme = "onedark",
        }
      })
    end,
  }
  use 'lewis6991/gitsigns.nvim'
  use { 'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      require("nvim-tree").setup()
    end
  }
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  --[[
  use { "folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  --]]

  use 'xiyaowong/transparent.nvim'


  -- automatically set up your configuration after cloning packer.nvim
  -- put this at the end after all plugins
  if packer_bootstrap then
    _packer.sync()
  end
end)
--
--
--
--
--
-- /////////////////////////////////////////////////////////////////////////////////
-- /////////// configs
--require("barbar").setup()

require("transparent").setup({
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
  },
  extra_groups = {}, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})

local cmp=require("cmp");
cmp.setup({
  mapping = cmp.mapping.preset.insert({
      --['<C-b>'] = cmp.mapping.scroll_docs(-4),
      --['<C-f>'] = cmp.mapping.scroll_docs(4),
      --['<C-Space>'] = cmp.mapping.complete(),
      --['<C-e>'] = cmp.mapping.abort(),
      --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    --{ name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
    -- { name = 'cmdline' },
  })
})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
--
--
--
--
--
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lspconfig_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --[[
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  ]]--
  --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  --vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<C-A-l>', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local _lsp = require("lspconfig");
_lsp["tsserver"].setup { on_attach = lspconfig_on_attach, }
_lsp["clangd"].setup { on_attach = lspconfig_on_attach, }
_lsp["luau_lsp"].setup{ on_attach = lspconfig_on_attach, }
_lsp["grammarly"].setup { on_attach = lspconfig_on_attach,}
_lsp["html"].setup {on_attach = lspconfig_on_attach, }
_lsp["jsonls"].setup { on_attach = lspconfig_on_attach,}
_lsp["cssls"].setup { on_attach = lspconfig_on_attach,}
_lsp["pyright"].setup { on_attach = lspconfig_on_attach,}

--
--
--
--
--
--
require('gitsigns').setup{
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    --map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    --map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    --map('n', '<leader>hS', gs.stage_buffer)
    --map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>gd', gs.preview_hunk)
    map('n', '<leader>gs', gs.stage_hunk)
    map('n', '<leader>gu', gs.undo_stage_hunk)
    map('n', '<leader>gb', gs.toggle_current_line_blame)
    --map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    --map('n', '<leader>hd', gs.diffthis)
    --map('n', '<leader>hD', function() gs.diffthis('~') end)
    --map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    --map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
--
--
--
--
--
--
--
local previewers = require("telescope.previewers")
local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end
--local actions = require("telescope.actions")
--local trouble = require("trouble.providers.telescope")
require('telescope').setup{
  defaults = {
    mappings = {
    },
    buffer_previewer_maker = new_maker,
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key"
        -- ["<c-t>"] = trouble.open_with_trouble 
      },
      n = { 
        -- ["<c-t>"] = trouble.open_with_trouble 
      },
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
--
--
--
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "javascript", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ---ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- /////////// end of config
-- /////////////////////////////////////////////////////////////////////////////////
--
--
--
--
--
--
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- # Add global bindings for telescope.nvim
map("n", "<C-e>", "<cmd>lua require('telescope.builtin').buffers()<CR>")
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>")
map("n", "<C-A-p>", "<cmd>lua require('telescope.builtin').buffers()<CR>")
map("n", "<A-/>", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n", "<C-/>", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n", "<A-d>", "<cmd>lua require('telescope.builtin').diagnostics()<CR>")
map("n", "<A-o>", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
--
--
--
-- Lua
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
--
--
--
--
--cmd [[colorscheme nightfox]]
cmd [[colorscheme nightfox]]
cmd [[map <C-j> <C-W>j]]
cmd [[map <C-k> <C-W>k]]
cmd [[map <C-h> <C-W>h]]
cmd [[map <C-l> <C-W>l]]
cmd [[nmap <A-j> mz:m+<CR>`z]]
cmd [[nmap <A-k> mz:m-2<CR>`z]]
cmd [[vmap <A-j> :m'>+<CR>`<my`>mzgv`yo`z]]
cmd [[vmap <A-k> :m'<-2<CR>`>my`<mzgv`yo`z]]
cmd [[noremap <silent><leader>1 :tabn 1<CR>]]
cmd [[noremap <silent><leader>2 :tabn 2<CR>]]
cmd [[noremap <silent><leader>3 :tabn 3<CR>]]
cmd [[noremap <silent><leader>4 :tabn 4<CR>]]
cmd [[noremap <silent><leader>5 :tabn 5<CR>]]
cmd [[noremap <silent><leader>6 :tabn 6<CR>]]
cmd [[noremap <silent><leader>7 :tabn 7<CR>]]
cmd [[noremap <silent><leader>8 :tabn 8<CR>]]
cmd [[noremap <silent><leader>9 :tabn 9<CR>]]
cmd [[noremap <silent><leader>0 :tabn 10<CR>]]
cmd [[inoremap jk <esc>]]
cmd [[nnoremap <leader>e :NvimTreeToggle<CR>]]
cmd [[nnoremap <A-q> :q<CR>]]
cmd [[nnoremap <C-s> :w<CR>]]


--
cmd [[
function! s:GetCurrBufNames(tabCount)
    let bufNames = {}
    for i in range(a:tabCount)
        let tabNum = i + 1
        let winNum = tabpagewinnr(tabNum)
        let buflist = tabpagebuflist(tabNum)
        let bufNum = buflist[winNum - 1]
        let bufName = bufname(bufNum)
        if bufName !=# ''
            let bufName = fnamemodify(bufName, ':~:.')
        endif
        let baseName = fnamemodify(bufName, ':t')
        let bufNames[tabNum] = {}
        let bufNames[tabNum]['fn'] = bufName
        let bufNames[tabNum]['bn'] = baseName
        let bufNames[tabNum]['sn'] = baseName
    endfor

    let bnGroup = {}
    for [tabNum, name] in items(bufNames)
        let bn = name['bn']
        if !has_key(bnGroup, bn)
            let bnGroup[bn] = []
        endif
        let bnGroup[bn] = add(bnGroup[bn], tabNum)
    endfor

    for tabNums in values(bnGroup)
        if len(tabNums) > 1
            for tabNum in tabNums
                let bufNames[tabNum]['sn'] = bufNames[tabNum]['fn']
            endfor
        endif
    endfor

    return bufNames
endfunction

function! MyTabline()
    let s = ''
    let tabCount = tabpagenr('$')
    let bufNames = s:GetCurrBufNames(tabCount)
    for i in range(tabCount)
        let tabNum = i + 1
        let winNum = tabpagewinnr(tabNum)
        let buflist = tabpagebuflist(tabNum)
        let bufNum = buflist[winNum - 1]
        let bufName = bufNames[tabNum]['sn']

        let bufmodified = 0
        for b in buflist
            if getbufvar(b, '&modified')
                let bufmodified = 1
                break
            endif
        endfor

        let fname = '' 
        let buftype = getbufvar(bufNum, '&buftype')
        if buftype ==# ''
            let fname = bufName !=# '' ? bufName : '[No Name]'
        elseif buftype ==# 'quickfix'
            let fname = '[Quickfix List]'
        elseif buftype ==# 'help'
            let fname = '[Help]'
        else
            let fname = '[' . bufName . ']'
        endif

        " select the highlighting
        let hl = tabNum == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
        let s .= hl

        " set the tab page number (for mouse clicks)
        let s .= '%' . tabNum . 'T'

        let s .= ' [' . tabNum . '] '

        if exists('g:tabline_show_wins_count')
            let winCount = tabpagewinnr(tabNum, '$')
            if winCount > 1
                let s .= '%#TabWinsCount#' . winCount . hl . ' '
            endif
        endif

        let s .= fname . ' '

        if bufmodified
            let s .= '+ '
        endif
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabCount > 1
        let s .= '%=%#TabLine#%999XX'
    endif

    return s
endfunction
set tabline=%!MyTabline()
]]
--
--
--
--
--
cmd [[
let s:is_win = has('win32') || has('win64')
if s:is_win
    " ... other Windows specific settings

    nmap <C-z> <Nop>
endif
]]


cmd "set syntax=enable"
cmd "set listchars=tab:>-"
cmd "syn on"
--
cmd "set nofoldenable"
cmd "set foldlevel=99"
--cmd "set foldmethod=indent"
cmd "set foldmethod=expr"
cmd "set foldexpr=nvim_treesitter#foldexpr()"

    --autocmd WinEnter * set relativenumber
    --autocmd WinLeave * set norelativenumber
cmd [[
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END
]]
