" Programs Required for some stuff:
" - rg
" - LSP servers = rust-analyzer, clangd

call plug#begin('~/.local/share/nvim/plugged')
Plug 'kjssad/quantum.vim'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
Plug 'simrat39/rust-tools.nvim'
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
nn <leader>h :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
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
" todo and note
nmap <leader>9 oTODO(lucypero):<ESC>gccA 
nmap <leader>0 oNOTE(lucypero):<ESC>gccA 
" unload buffer
nn <leader>D :bd<cr>
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

"" --------  Mappings and config - Nvim LSP ----------

nn gR <CMD>lua vim.lsp.buf.rename()<CR>
nn gr <CMD>lua vim.lsp.buf.references()<CR>
nn gi <CMD>lua vim.lsp.buf.implementation()<CR>
nn gd <CMD>lua vim.lsp.buf.definition()<CR>
nn M <CMD>lua vim.lsp.buf.hover()<CR>
nn L <CMD>lua vim.lsp.buf.code_action()<CR>
nn H <CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nn ge <CMD>lua vim.lsp.diagnostic.set_loclist()<CR>

lua <<EOF
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
require('lspconfig').rust_analyzer.setup{
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}

require('lspconfig').clangd.setup{}

setup_diagnostics()
EOF


"" --------  Mappings and config - Rust Tools ----------
lua <<EOF
require('rust-tools').setup({})
EOF

"" --------  Mappings and config - Treesitter ----------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "json", "javascript", "go", "python", "rust", "query", "lua", "toml"},
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "rc",
      node_decremental = "grm",
    },
  },
  textobjects = {
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          -- Or you can define your own textobjects like this
          ["iF"] = {
            python = "(function_definition) @function",
            cpp = "(function_definition) @function",
            c = "(function_definition) @function",
            java = "(method_declaration) @function",
          },
        },
      },
move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    },
}
EOF

"" --------  Mappings and config - Asyncrun plugin ----------
" " F10 to toggle quickfix window	(needs asyncrun plugin)

nn <F10> :call asyncrun#quickfix_toggle(15)<cr>	

function! s:build_project()	
  execute "wa"	

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
" vim fugitive config
nn <leader>Gs :Git<cr>

"" --------  Mappings and config - hop.nvim ----------
" hop.nvim config
nn s :HopWord<cr>

"" --------  Mappings and config - nvim-tree ----------
" nvim tree config
nn <leader>f :NvimTreeToggle<CR>

"" --------  Mappings and config - Telescope ----------
" search files
nn <leader>o :Telescope find_files<cr>
nn <leader>b :Telescope buffers<cr>
nn <leader>r :Telescope live_grep<cr>

" worskpace symbols
nn <leader>cw :Telescope lsp_workspace_symbols<cr>
" document symbols
nn <leader>cp :Telescope lsp_document_symbols<cr>

lua <<EOF
require('telescope').setup{
  defaults = {
    layout_strategy = "horizontal",
  }
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

"" --------  Mappings and config - delimitMate ----------
" " delimitMate configuration
let delimitMate_expand_cr = 1

"" --------  Mappings and config - vim-obsession ----------
" Autoload sessions created by tpope's vim-obsession when starting Vim.

augroup sourcesession
        autocmd!
        autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END
