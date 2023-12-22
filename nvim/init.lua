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
opt.wrap=true
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
cmd [[
let s:is_win = has('win32') || has('win64')
if s:is_win
    " ... other Windows specific settings

    nmap <C-z> <Nop>
endif
]]
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
  "EdenEast/nightfox.nvim",

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },


  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = true,
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
    },
    --[[
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "nvim-tree" },
    },
    --]]
  },


  {
    "nvim-lua/plenary.nvim",
  },


  {
    "xiyaowong/transparent.nvim",
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



  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = {
      sections = {
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
        },
      },
    },
  },


  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "html", "javascript", "jsdoc", "json", "jsonc", "typescript",
        "markdown", "markdown_inline",
        "lua", "luadoc", "luap",
        "python",
        "query", "regex",
        "vim", "vimdoc",
        "tsx",
        "toml", "yaml",
        "bash", "c", "diff",
      },
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
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },


  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
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
  },




  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "rust_analyzer" },
    }
  },





  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { hidden = true, default_text = line })()
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = { },
            n = { },
          },
        },
      }
    end,
    keys = function()
      local builtin = require('telescope.builtin')
      return {
          {
              '<C-p>',
              "<cmd>lua require('telescope.builtin').buffers()<CR>"
          },
      }
    end,
  },


  {
    "neovim/nvim-lspconfig",
    config = function(_, opts)
      local lspconfig_on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<C-A-l>', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "tsserver", "clangd", "luau_lsp", "grammarly", "html", "jsonls", "cssls", "pyright"}
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = lspconfig_on_attach,
          capabilities = capabilities,
        }
      end
    end,
  },



  {
    "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    module = true,
  },
  {
    "hrsh7th/cmp-buffer",
    module = true,
  },
  {
    "hrsh7th/cmp-path",
    module = true,
  },
  {
    "hrsh7th/cmp-cmdline",
    module = true,
  },
}
local _options = {}
require("lazy").setup(_plugins, _options)
--
--
--
--
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
-- Misc
--==========================================================================================
cmd [[colorscheme nightfox]]
--[[
local function MapLocalKey(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
MapLocalKey("n", "<C-e>", "<cmd>lua require('telescope.builtin').buffers()<CR>")
MapLocalKey("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>")
MapLocalKey("n", "<C-A-p>", "<cmd>lua require('telescope.builtin').buffers()<CR>")
MapLocalKey("n", "<A-/>", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
MapLocalKey("n", "<C-/>", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
MapLocalKey("n", "<A-d>", "<cmd>lua require('telescope.builtin').diagnostics()<CR>")
MapLocalKey("n", "<A-o>", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
--]]

