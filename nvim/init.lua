local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local opt = vim.opt  -- to set options
local g = vim.g
local fn = vim.fn
local api = vim.api
--
--
--
--
--==========================================================================================
-- Basic Configurations.
--==========================================================================================
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
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.termguicolors = true            -- True color support
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
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.cursorline = true
opt.hlsearch=true
opt.incsearch=true
opt.ttimeoutlen=50
opt.updatetime=100
opt.wrap=false -- soft wrap;
opt.linebreak=true
--
--
--
--
--
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
cmd [[nnoremap <A-q> :q<CR>]]
cmd [[nnoremap <C-s> :w<CR>]]
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
--
--
--
--
--==========================================================================================
-- Plugin Start.
--==========================================================================================
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
opt.rtp:prepend(lazypath)
--
--
local _plugins = {
    {
        "EdenEast/nightfox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd [[colorscheme nightfox]]
        end,
    },




    { "nvim-lua/plenary.nvim", lazy = true, },
    { "nvim-tree/nvim-web-devicons", lazy = true, },





----------------------------------------------------------------------------------
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            sort = { sorter = "case_sensitive", },
            view = { width = 30, },
            renderer = { group_empty = true, },
            filters = { dotfiles = true, },
        },
        config = function(_, opts) require("nvim-tree").setup(opts) end,
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "nvim-tree" },
        },
    },








----------------------------------------------------------------------------------
    --[[
    {
        "xiyaowong/transparent.nvim",
        lazy = true,
        event = "VimEnter",
        opts = {
            groups = { -- table: default groups
                'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                'SignColumn', 'CursorLineNr', 'EndOfBuffer',
            },
            extra_groups = {}, -- table: additional groups that should be cleared
            exclude_groups = {}, -- table: groups you don't want to clear
        },
    },
    --]]







----------------------------------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                vim.o.statusline = " " -- set an empty statusline till lualine loads
            else
                vim.o.laststatus = 0 -- hide the statusline on the starter page
            end
        end,
        opts = {
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
        },
    },






----------------------------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = "VeryLazy",
        --lazy = true,
        --event = {"BufRead", "BufNewFile"},
        --event = {"BufEnter"},
        --cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            ensure_installed = {
                "javascript", "typescript", 
                "json",-- "json5", "jsonc",
                "jsdoc", "html", 
                "markdown", -- "markdown_inline",
                -- "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
                -- "bash", "diff",
                "toml", "yaml",
                "query", "regex",
                "lua", -- "luadoc", "luap",
                "glsl",
                -- "vim", "vimdoc",
                --"python", "tsx", 
                "c",
            },
            sync_install = false,
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                local added = {}
                local function _fn(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end
                opts.ensure_installed = vim.tbl_filter(_fn, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
    },





----------------------------------------------------------------------------------
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        lazy = true,
        build = ":MasonUpdate",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
        -- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    },




  --[[
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer" },
        }
    },
  --]]



----------------------------------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.5',
        cmd = "Telescope",
        lazy = true,
        version = false, -- telescope did only one release, so use HEAD for now
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        opts = function()
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

            return {
                defaults = {
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-h>"] = "which_key"
                        }
                    },
                    buffer_previewer_maker = new_maker,
                    layout_strategy = "vertical"
                },
            }
            end,
        keys = {
            { '<C-p>', "<cmd>lua require('telescope.builtin').find_files()<CR>" },
            { '<C-e>', "<cmd>lua require('telescope.builtin').buffers()<CR>" },
            { '<A-/>', "<cmd>lua require('telescope.builtin').live_grep()<CR>" },
            { '<A-d>', "<cmd>lua require('telescope.builtin').diagnostics()<CR>" },
            { '<A-o>', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>" },
            --{ '<A-n>', "<cmd>lua require('telescope.builtin').search_history()<CR>" },
        }
    },




----------------------------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        init = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf, noremap = true, silent = true }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<C-A-l>', function() vim.lsp.buf.format { async = true } end, opts)
                    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    --vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
                    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    --vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                end,
                }
            )
        end,
        config = function(_, opts)
            --local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            local servers = { "tsserver", "html", "jsonls", "cssls"}
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                    --capabilities = capabilities,
                }
            end

	    local root_pattern = require("lspconfig.util").root_pattern(
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"Makefile",
		"configure.ac",
		"configure.in",
		"config.h.in",
		"meson.build",
		"meson_options.txt",
		"build.ninja",
		".git"
	    )
            lspconfig.clangd.setup {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                filetypes = { "c", "cpp", "cxx","cc", "objc", "objcpp", "cuda", "proto" },
                root_dir = function(fname)
                    return root_pattern(fname) 
                end,
            }
        end,
    },



    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        opts = function()
            local cmp = require('cmp');
            return {
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
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
            }
        end,
        config = function(_, opts)
            require('cmp').setup(opts);
        end,
    },




---------------------------------------------------------------------------------
    --[[
    -- takes long time to load, and I'v been using less times than I expected.
    {
        "folke/which-key.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function(_, opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require('which-key').setup();
        end,
    },
    --]]




---------------------------------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        --lazy = true,
        opts = {
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
            watch_gitdir = { interval = 1000, follow_files = true },
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
            yadm = { enable = false },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']h', function()
                    if vim.wo.diff then return ']h' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                map('n', '[h', function()
                    if vim.wo.diff then return '[h' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                -- Actions
                map('n', '<leader>gd', gs.preview_hunk)
                map('n', '<leader>gb', gs.toggle_current_line_blame)
                --[[
                map('n', '<leader>gu', gs.undo_stage_hunk)
                map('n', '<leader>gs', gs.stage_hunk)
                map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                map('n', '<leader>hS', gs.stage_buffer)
                map('n', '<leader>hR', gs.reset_buffer)
                map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>hD', function() gs.diffthis('~') end)
                map('n', '<leader>td', gs.toggle_deleted)

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                --]]
            end
        },
        config = function(_, opts)
            require('gitsigns').setup(opts)
        end,
    },





---------------------------------------------------------------------------------
    --[[
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            --{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            --{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            --{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            --{ "<c-j>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    --]]











---------------------------------------------------------------------------------
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = true,
        opts = {
            position = "bottom", -- position of the list can be: bottom, top, left, right
            height = 10, -- height of the trouble list when position is top or bottom
            width = 50, -- width of the list when position is left or right
            icons = true, -- use devicons for filenames
            mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
            severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
            fold_open = "", -- icon used for open folds
            fold_closed = "", -- icon used for closed folds
            group = true, -- group results by file
            padding = true, -- add an extra new line on top of the list
            cycle_results = true, -- cycle item list when reaching beginning or end of list
            action_keys = { -- key mappings for actions in the trouble list
                -- map to {} to remove a mapping, for example:
                -- close = {},
                close = "q", -- close the list
                cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                refresh = "r", -- manually refresh
                jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
                open_split = { "<c-x>" }, -- open buffer in new split
                open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
                open_tab = { "<c-t>" }, -- open buffer in new tab
                jump_close = {"o"}, -- jump to the diagnostic and close the list
                toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
                switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
                toggle_preview = "P", -- toggle auto_preview
                hover = "K", -- opens a small popup with the full multiline message
                preview = "p", -- preview the diagnostic location
                open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
                close_folds = {"zM", "zm"}, -- close all folds
                open_folds = {"zR", "zr"}, -- open all folds
                toggle_fold = {"zA", "za"}, -- toggle fold of current file
                previous = "k", -- previous item
                next = "j", -- next item
                help = "?", -- help menu
            },
            multiline = true, -- render multi-line messages
            indent_lines = true, -- add an indent guide below the fold icons
            win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
            auto_open = false, -- automatically open the list when you have diagnostics
            auto_close = false, -- automatically close the list when you have no diagnostics
            auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
            auto_fold = false, -- automatically fold a file trouble list at creation
            auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
            include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions"  }, -- for the given modes, include the declaration of the current symbol in the results
            signs = {
                -- icons / text used for a diagnostic
                error = "",
                warning = "",
                hint = "",
                information = "",
                other = "",
            },
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        },
        keys = {
            { '<leader>xx', "<cmd>TroubleToggle<CR>" },
            { '<leader>xd', "<cmd>TroubleToggle document_diagnostics<CR>" },
        }
    },





---------------------------------------------------------------------------------
--[[
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        opts = {
            -- needs a OpenAI API key, which needs to be actived by mobile phone, china local telecommunications' excluded.
            api_key_cmd = "op read op://private/OpenAI/credential --no-newline"
        },
        config = function(_, opts)
            require("chatgpt").setup(opts)
        end,
    },
    {
        --- needs to buy its service, microsoft provided.
        "github/copilot.vim",
    },
--]]







---------------------------------------------------------------------------------
    --[[
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { '<leader>l', "<cmd>LazyGit<CR>" },
        },
    },
    --]]







---------------------------------------------------------------------------------
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {"kevinhwang91/promise-async"},
        init = function()
            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        event = 'VeryLazy',
        --lazy = true,
        --event = {"BufRead", "BufNewFile"},
        --event = {"BufEnter"},
        opts = {
            provider_selector = function(bufnr, filetype, buftype)
                return {'treesitter', 'indent'}
            end,
            open_fold_hl_timeout = 150,
            close_fold_kinds = {'imports', 'comment'},
            preview = {
                win_config = {
                    border = {'', '─', '', '', '', '─', '', ''},
                    winhighlight = 'Normal:Folded',
                    winblend = 0
                },
                mappings = {
                    scrollU = '<C-u>',
                    scrollD = '<C-d>',
                    jumpTop = '[',
                    jumpBot = ']'
                }
            },
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, {chunkText, hlGroup})
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, {suffix, 'MoreMsg'})
                return newVirtText
            end,
        },
        config = function(_, opts)
            require("ufo").setup(opts)
        end,
        keys = {
            { 'zr', "<cmd>lua require('ufo').openAllFolds()<CR>" },
            { 'zm', "<cmd>lua require('ufo').closeAllFolds()<CR>" },
        },

    },
---------------------------------------------------------------------------------
    {
        --"github/copilot.vim",
    },
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
}
local _options = {}
require("lazy").setup(_plugins, _options)
--
--
--
--
--
--==========================================================================================
-- Misc
--==========================================================================================

