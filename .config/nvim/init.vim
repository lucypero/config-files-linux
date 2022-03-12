" Programs Required for some stuff:
" - rg
" - LSP servers = rust-analyzer, clangd, typescript-language-server
" - python3-venv (apt install --yes -- python3-venv) (for COQ)

call plug#begin('~/.local/share/nvim/plugged')
Plug 'kjssad/quantum.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-obsession'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'tpope/vim-fugitive'
Plug 'phaazon/hop.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" Ts stuff
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
call plug#end()

"" --------  Neovide config ----------
let g:neovide_fullscreen=v:false
let g:neovide_cursor_vfx_mode = "wireframe"
let g:neovide_transparency = 1
let g:neovide_cursor_animation_length=0
let g:neovide_cursor_trail_length=0

"" --------  Vim Set's ----------
" " disable netrw (it is bad)
autocmd FileType netrw setl bufhidden=wipe
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
au VimResized * wincmd =
set linespace=1
set guifont=FiraCode\ Nerd\ Font:h16
let g:netrw_fastbrowse = 0
set linebreak
set nowrap
set termguicolors
set background=dark
let mapleader = "-"
set title
set cursorline
set relativenumber
set clipboard=unnamedplus
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set mouse=a
set formatoptions-=cro
set ignorecase
set smartcase
set splitbelow splitright
set scrolloff=10
set shortmess+=A
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" " session to remember camelcase globals
set sessionoptions+=globals



"" --------  Theming ----------
colorscheme quantum

" " modifications to quantum theme
hi StatusLine guibg=#252525 guifg=white
hi LineNr guifg=#aaaaaa
hi CursorLineNr guifg=white
hi Normal guibg=#252525
hi NormalFloat guibg=#555555
hi PmenuSel guibg=#e3b6e2 guifg=black
hi Visual guifg=black guibg=#e3b6e2
" " disable italics
hi Comment gui=NONE
hi Type gui=NONE
hi StorageClass gui=NONE
hi elixirPseudoVariable gui=NONE
hi jsFuncArgs gui=NONE
hi jsThis gui=NONE
hi jsSuper gui=NONE
hi htmlTagName gui=NONE

"" --------  Transparent background ----------

function! AdaptColorscheme()
   highlight clear CursorLine
   highlight Normal ctermbg=none
   highlight LineNr ctermbg=none
   highlight Folded ctermbg=none
   highlight NonText ctermbg=none
   highlight SpecialKey ctermbg=none
   highlight VertSplit ctermbg=none
   highlight SignColumn ctermbg=none
endfunction
autocmd ColorScheme * call AdaptColorscheme()

highlight Normal guibg=NONE ctermbg=NONE
highlight CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLineNr cterm=NONE ctermbg=NONE ctermfg=NONE
highlight clear LineNr
highlight clear SignColumn
highlight clear StatusLine


" Change Color when entering Insert Mode
autocmd InsertEnter * set nocursorline

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * set nocursorline

"" extra settings, uncomment them if necessary :) 
"set cursorline
"set noshowmode
set nocursorline

"" --------  Mappings (no plugins) ----------

" leader p for pasting what is in the "0 register (last yank that was not a delete)
nn <leader>p "0p
nn <leader>P "0P
vn <leader>p "0p
vn <leader>P "0P
" save all shortcut
nn <leader>s :w <cr>
nn <leader>S :wa <cr>
" Swap ; and :
nn ; :
nn : ;
vn ; :
vn : ;
nn <leader>w <C-w><C-w>
nn <C-h> <C-w>h
nn <C-j> <C-w>j
nn <C-k> <C-w>k
nn <C-l> <C-w>l
" unload current buffer
nn <leader>qq :bp\|bd #<cr>
" switch header file <-> implementation file
nn <leader>H :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" shortcut for setting up 2 windows with the current buffer in both of them
nn <C-s> <C-W>o:vsp<cr>
" shortcut for going back to prev file
nn <leader>1 <C-^>
"" quicklist: previous, next and current
nn <leader>[ :cp<cr>
nn <leader>] :cn<cr>
nn <leader>} :cc<cr>
"" location list: previous, next and current
nn <leader>g[ :lp<cr>
nn <leader>g] :lne<cr>
" go to vim config
nn <leader><F3> :e $MYVIMRC<CR>
nn <leader><F4> :e ~/.config/nvim/lua<CR>
" todo and note
nmap <leader>9 oTODO(lucypero):<ESC>gccA 
nmap <leader>0 oNOTE(lucypero):<ESC>gccA 
" close buffer quickly
nn <c-q> :q<cr>
" quit vim
nn <leader><c-q> :qa<cr>
" swapping # and * mappings because i want to use * much more often and it is harder to reach
nn # *
nn * #
" " buffer/window navigation
nn <Tab> :bn<cr>
nn <S-Tab> :bp<cr>
" Command to set the current directory to the dir where the current file is
command! SetCDToFileDir cd %:p:h
nn <leader>W :SetCDToFileDir<cr>
" Insert semicolon at EOL
nn <leader>; A;<esc>
" " location list mappings
nn <leader>ln :lnext<cr>
nn <leader>lp :lprevious<cr>
nn <leader>lf :lfirst<cr>
nn <leader>ll :llast<cr>
nn <leader>lo :lopen<cr>
nn <leader>lc :lclose<cr>
" quickfix list mappings
nn <leader>qf :cfirst<cr>
nn <leader>ql :clast<cr>
" toggle nowrap
nn <leader>nw :set nowrap!<cr>

" " Terminal
nn <silent> <C-\> :terminal<cr>
nn <silent> <A-\> :terminal<cr>
tno <silent> <C-\> <C-\><C-n>
tno <silent> <A-\> <C-\><C-n>

function! Scratch()
    execute "e scratch"
    execute "setlocal buftype=nofile"
    execute "setlocal bufhidden=hide"
    execute "setlocal noswapfile"
endfunction

command! Scratch execute Scratch()

" source vimrc when saving
augroup reload_vimrc
autocmd!
autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"" --------  Statusline ----------
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ LucyNvim\ <3\ 
set statusline+=%#StatusLine#
set statusline+=\ %f\ %m\ %r\ 
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

"" ----------- Clipboard fix for WSL2 ---------
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
  endif


"" --------  Mappings and config - Nvim LSP ----------

nn gR <CMD>lua vim.lsp.buf.rename()<CR>
nn gr <CMD>lua vim.lsp.buf.references()<CR>
nn gi <CMD>lua vim.lsp.buf.implementation()<CR>
nn gd <CMD>lua vim.lsp.buf.definition()<CR>
nn M <CMD>lua vim.lsp.buf.hover()<CR>
nn L <CMD>lua vim.lsp.buf.code_action()<CR>
nn H <CMD>lua vim.diagnostic.open_float()<CR>
nn ge <CMD>lua vim.diagnostic.setloclist()<CR>
nn <leader>ff <cmd>lua vim.lsp.buf.formatting()<CR>

lua <<EOF

local lspconfig = require("lspconfig")


local function setup_diagnostics()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        severity_sort = true,
      }
    )
end

-- rustup component add rust-src
lspconfig.rust_analyzer.setup{
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}

lspconfig.clangd.setup{}

-- adding typescript
local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

local on_attach = function(client, bufnr)
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
--    buf_map(bufnr, "n", "gd", ":LspDef<CR>")
--    buf_map(bufnr, "n", "gr", ":LspRename<CR>")
--    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
--    buf_map(bufnr, "n", "K", ":LspHover<CR>")
--    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
--    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
--    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
--    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
--    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
--    if client.resolved_capabilities.document_formatting then
--        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
--    end
end

lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        --buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        --buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        --buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        on_attach(client, bufnr)
    end,
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach
})

setup_diagnostics()
EOF

"" --------  Mappings and config - Rust Tools ----------
lua <<EOF
require('rust-tools').setup({})
EOF

"" --------  Mappings and config - Asyncrun plugin ----------
" " F10 to toggle quickfix window	(needs asyncrun plugin)

nn <F10> :call asyncrun#quickfix_toggle(15)<cr>	

function! s:build_project()	
  execute "wa"	

  execute "AsyncStop"

  " first, check if SessionBuildProjectCommand variable is set 
  "  if it is, then run that command
  if exists("g:SessionBuildProjectCommand")
    execute "AsyncRun " . g:SessionBuildProjectCommand
    return
  endif

  if &filetype ==# "python"
    execute "AsyncRun -raw python -u %"	
  elseif  &filetype ==# "c" || &filetype ==# "cpp"
    execute "AsyncRun \.\/build.sh"	
  elseif &filetype ==# "odin"
    execute "AsyncRun odin run %"	
  elseif &filetype ==# "lua"
    execute "AsyncRun lua5.3 %"
  elseif &filetype ==# "rust"
    execute "AsyncRun cargo build"
  elseif &filetype ==# "haskell"
    execute "AsyncRun runghc %"
  endif	
endfunction	
function! s:set_session_build_command(build_cmd)
  let g:SessionBuildProjectCommand = a:build_cmd
endfunction
command! -nargs=1 SetSessionBuildCommand call s:set_session_build_command(<args>)
"async run way
noremap <silent> <F8> :call <sid>build_project()<cr>
"stop process
noremap <silent> <leader><F8> :AsyncStop<cr>

"" --------  Mappings and config - Vista ----------
nn <leader>v :Vista!!<cr>
let g:vista_default_executive = 'nvim_lsp'
let g:vista_sidebar_width = 60
let g:vista_ignore_kinds = ["EnumMember", "Field", "TypeParameter"]
let g:vista_close_on_jump = 1
let g:vista_echo_cursor = 0
let g:vista_echo_cursor_strategy = "floating_win"
let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]

"" --------  Mappings and config - Fugitive ----------
nn <leader>Gs :Git<cr>

"" --------  Mappings and config - hop.nvim ----------
lua <<EOF
require'hop'.setup()
EOF
nn s :HopWord<cr>

"" --------  Mappings and config - nvim-tree ----------
lua <<EOF
require'nvim-tree'.setup()
EOF

nn <leader>F :NvimTreeToggle<CR>

"" --------  Mappings and config - Telescope ----------
lua <<EOF
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local l = require('lucy')

local delete_buffers = function(prompt_bufnr)
   actions.smart_send_to_qflist(prompt_bufnr)
   vim.api.nvim_command('cfdo :bd')
end

-- telescope related mappings
l.nn('<leader>o', ":lua require('lucy').t_cmd('find_files')<cr>")
l.nn('<leader>b', ":lua require('lucy').t_cmd('buffers')<cr>")
l.nn('<leader>r', ":lua require('lucy').t_cmd('live_grep')<cr>")
l.nn('<leader>cw', ":lua require('lucy').t_cmd('lsp_workspace_symbols')<cr>")
l.nn('<leader>cp', ":lua require('lucy').t_cmd('lsp_document_symbols')<cr>")
l.nn('<leader>h', ":lua require('lucy').t_cmd('help_tags')<cr>")
l.nn('<leader>d', ":lua require('lucy').t_cmd('diagnostics', {bufnr = 0})<cr>")
l.nn('<leader>D', ":lua require('lucy').t_cmd('diagnostics')<cr>")

-- telescope settings and mappings (inside telescope)
require('telescope').setup{
defaults = {
  layout_strategy = "horizontal",
  mappings = {
    i = {
      ["<esc>"] = actions.close,
      ["<C-q>"] = actions.smart_send_to_qflist,
      ["<C-a>"] = actions.select_all,
      ["<C-s>"] = actions.toggle_selection,
      ["<C-d>"] = actions.drop_all,
      ["<C-x>"] = delete_buffers,
      },
    },
  },
}
EOF

"" --------  Mappings and config - Bufferline ----------
" " Bufferline setup
lua <<EOF
require'bufferline'.setup{
  options = {
    always_show_bufferline = false
  }
}
EOF

"" --------  Mappings and config - Coq (autocomplete) ----------
let g:coq_settings = {
      \ 'auto_start': 'shut-up',
      \ 'keymap.manual_complete': '<C-Space>',
      \ 'keymap.jump_to_mark': '',
      \ 'keymap.bigger_preview': '<C-k>',
      \ 'keymap.repeat': '',
      \ 'keymap.eval_snips': '',
      \ }

ino <silent><expr> <Esc> pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c> pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS> pumvisible() ? "\<C-e><BS>" : "\<BS>"
ino <silent><expr> <CR> pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"

"" --------  Mappings and config - vim-obsession ----------
" Autoload sessions created by tpope's vim-obsession when starting Vim.

augroup sourcesession
        autocmd!
        autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END
