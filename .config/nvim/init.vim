" Programs Required for some stuff:
" rg;fzf

let g:polyglot_disabled = ['python', 'c', 'cpp', 'json']

let g:coc_global_extensions = [
\ 'coc-marketplace',
\ 'coc-json',
\ 'coc-vimlsp',
\ 'coc-rust-analyzer'
\ ]

call plug#begin('~/.local/share/nvim/plugged')
" color schemes
Plug 'kjssad/quantum.vim'
" rest
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
" Plug 'jremmen/vim-ripgrep'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'ap/vim-css-color'
Plug 'tpope/vim-obsession'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'tpope/vim-fugitive'
" snippets
Plug 'honza/vim-snippets'
Plug 'phaazon/hop.nvim'

" vim-telescope. Very promising. Still not fully done yet. Does not work well with  coc :/ so i can's search symbols
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

Plug 'mfussenegger/nvim-dap'
Plug 'Shougo/echodoc.vim'
Plug 'liuchengxu/vista.vim'

call plug#end()

" " gui config and neovide config
set linespace=1
set guifont=FiraCode\ Nerd\ Font:h16

" " neovide config
let g:neovide_fullscreen=v:false
let g:neovide_cursor_vfx_mode = "wireframe"
let g:neovide_transparency = 1
let g:neovide_cursor_animation_length=0
let g:neovide_cursor_trail_length=0

" " close netrw
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0

" " to wrap, or not to wrap?
set linebreak
set nowrap " do not visually wrap the lines so they horizontally fit in the window

" "  --------- THEMING  -----------

" " Color theme config
set termguicolors
set background=dark

colorscheme quantum

" modifications to quantum theme
hi StatusLine guibg=#303030 guifg=white
hi LineNr guifg=#aaaaaa
hi CursorLineNr guifg=white
hi Normal guibg=#333333
hi NormalFloat guibg=#555555
hi PmenuSel guibg=#e3b6e2 guifg=black
hi Visual guifg=black guibg=#e3b6e2

" disable italics
hi Comment gui=NONE
hi Type gui=NONE
hi StorageClass gui=NONE
hi elixirPseudoVariable gui=NONE
hi jsFuncArgs gui=NONE
hi jsThis gui=NONE
hi jsSuper gui=NONE
hi htmlTagName gui=NONE

let mapleader = "-"

set title

set cursorline

" " line number - relative
set relativenumber

" set clipboard register to be the default register. 
set clipboard=unnamedplus

" leader p for pasting what is in the "0 register (last yank that was not a delete)
nnoremap <leader>p "0p
nnoremap <leader>P "0P
vnoremap <leader>p "0p
vnoremap <leader>P "0P

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set mouse=a

" TODO(lucypero): can you combine the following two lines?
" " indent with tabs on gdscript files
autocmd Filetype gdscript3 setlocal autoindent tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" " indent python files wth tabs
" au FileType python setlocal autoindent tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" " save all shortcut
nnoremap <leader>s :w <cr>
nnoremap <leader>S :wa <cr>

" " Swap ; and :
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" " see tabs and trailing characters
" set list
" set listchars=tab:>\ ,trail:·
nnoremap <leader>w <C-w><C-w>

" " mapping enter and ctrl+enter to newline insertion
nnoremap <space> o<Esc>k
nnoremap <c-space> O<Esc>j

" " mapping c-enter to make a newline without going in insert mode
nnoremap <c-cr> o<esc>

set formatoptions-=cro

" " vim-commentary configuration
autocmd FileType c,cpp,java,odin setlocal commentstring=//\ %s
autocmd FileType gdscript3 setlocal commentstring=#\ %s

" " delimitMate configuration
let delimitMate_expand_cr = 1

" " Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" " File searching
set path+=**
set wildmenu
" ignore these file extensions when opening file
set wildignore+=*.pdf,*.o,*.so,*.obj,*.jpg,*.png
" ignoring folders
set wildignore+=*/node_modules/*,*/bin/*
" suffixes are for file extension priority when searching files. i don't need them now
" set suffixes+=.pdf

" " case insensitive search as the default (use \C or use a capital letter for case sensitive search)
set ignorecase
set smartcase

" " Splits open at the bottom and right
set splitbelow splitright

" " Shortcutting split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" " set scrolloff so that the cursor does not reach the edges of the screen (which is never good)
set scrolloff=10

" unload current buffer
noremap <leader>qq :bp\|bd #<cr>

" switch header file <-> implementation file
nnoremap <leader>h :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Disable that annoying swap file warning
set shortmess+=A

" " shortcut for setting up 2 windows with the current buffer in both of them
nnoremap <C-s> <C-W>o:vsp<cr>

" " shortcut for going back to prev file
nnoremap <leader>1 <C-^>

" " go to previous error
nnoremap <leader>[ :cp<cr>
" " go to next error
nnoremap <leader>] :cn<cr>
" " go to current error
nnoremap <leader>} :cc<cr>

" " go to vim config
nnoremap <leader><F3> :e $MYVIMRC<CR>

function! Scratch()
    execute "e scratch"
    execute "setlocal buftype=nofile"
    execute "setlocal bufhidden=hide"
    execute "setlocal noswapfile"
endfunction

command! Scratch execute Scratch()

" " sources local file if it exists
" "    in that file, you set up all the configuration that is particular to
" "    the local machine you are using.
let s:local_file_name = "init.local.vim"
let s:path = expand('<sfile>:p:h') . "/" . s:local_file_name
if filereadable(s:path)
  runtime init.local.vim
endif

" type todo - //TODO(lucypero): blabla
nmap <leader>9 oTODO(lucypero):<ESC>gccA 
" type note - //NOTE(lucypero): blabla
nmap <leader>0 oNOTE(lucypero):<ESC>gccA 

" unload buffer
nnoremap <leader>D :bd<cr>

" source vimrc when saving
augroup reload_vimrc
autocmd!
autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" disable netrw (it is bad)
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

au VimResized * wincmd =

" Treesitter config

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "json", "javascript", "go", "python", "rust", "query", "lua"},
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

" code fold config:
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" to get rid of the ^M's that sometimes show up for some reason
" nnoremap <leader>Rm :e ++ff=dos<cr>

" close buffer quickly
nnoremap <c-q> :q<cr>

" quit vim
nnoremap <leader><c-q> :qa<cr>


" ----------- Plugin Config: CoC -----------

" coc highlight colors
highlight CocErrorHighlight ctermfg=Red  guifg=#ff0000

" set coc hints color to comment color
highlight link CocHintSign Comment

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Sign column takes too much space, I don't think I need it.
set signcolumn=no

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Stuff related to tab completion:

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <silent><expr> <C-j>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ?
      \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<cr>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Avoid showing message extra message when using completion
set shortmess+=c

" command to disable auto trigger completion on buffer
function! ToggleAutoTriggerCompletion()
  " if not exist, set it to one
  if !exists("b:coc_suggest_disable")
    let b:coc_suggest_disable = 0
  endif
  " then toggle it
  let b:coc_suggest_disable = !b:coc_suggest_disable
endfunc
nnoremap <leader>cA :call ToggleAutoTriggerCompletion()<cr>

nnoremap <silent> <leader>ca :CocAction<cr>
vnoremap <silent> <leader>ca :CocAction<cr>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" rename symbol
nmap <silent> gR <Plug>(coc-rename)

" format buffer
nmap <silent> <leader>cf <Plug>(coc-format)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Display CoC Diagnostics
" all Coc mapping will start with <leader>c

nnoremap <leader>cd :CocList diagnostics<cr>
nnoremap <leader>co :CocList --auto-preview outline<cr>
nnoremap <leader>cs :CocList --auto-preview -I symbols<cr>

"" Snippets

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

"disable auto trigger completion

" ----------- END - Plugin Config: CoC -----------

" swapping # and * mappings because i want to use * much more often and it is harder to reach
nnoremap # *
nnoremap * #

" searching for rule definitions in tree sitter grammar
function! GetRuleDefinition(rule)
    let l:the_command = '/^\s*' . a:rule . '\s*:'
    execute the_command
endfunction

" " F10 to toggle quickfix window	
nnoremap <F10> :call asyncrun#quickfix_toggle(15)<cr>	

function! s:run_file()	
  execute "w"	
  if &filetype ==# "python"
    execute "AsyncRun -raw python -u %"	
  elseif  &filetype ==# "c" || &filetype ==# "cpp"
    execute "AsyncRun runc %"	
  elseif &filetype ==# "odin"
    execute "AsyncRun odin run %"	
  elseif &filetype ==# "lua"
    execute "AsyncRun lua5.3 %"
  elseif &filetype ==# "rust"
    execute "AsyncRun rustc % -o ~/.cache/compiled_programs/%:t:r && ~/.cache/compiled_programs/%:t:r"
  elseif &filetype ==# "sh"
    execute "AsyncRun source %"
  endif	
endfunction	

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
" command! -nargs=1 SetSessionBuildCommand echo <q-args>

function! s:run_project()	
  execute "wa"	
  if &filetype ==# "rust"
    execute "AsyncRun cargo run"
  endif	
endfunction	

function! s:test_project()
  execute "wa"
  if &filetype ==# "rust"
    execute "AsyncRun cargo test"
  endif	
endfunction

" test rust project
command! Test call s:test_project()
" noremap <silent><leader><F8> :Test<cr>

"async run way
noremap <silent> <F8> :call <sid>build_project()<cr>
noremap <silent> <leader><F9> :call <sid>run_project()<cr>

"stop process
noremap <silent> <leader><F8> :AsyncStop<cr>

" run rust clippy
function! s:run_clippy()
  execute "wa"
  let l:hi = system("find . | grep \"\.rs$\" | xargs touch")
  execute "AsyncRun cargo clippy"
endfunction

noremap <silent> <leader>Rc :call <sid>run_clippy()<cr>

noremap <silent> <F9> :wa<cr>:call <sid>run_file()<cr>

"vim dispatch way
" noremap <silent> <F8> :wa<cr>:call <sid>compile_project()<cr>
" noremap <silent> <F9> :wa<cr>:call <sid>run_file()<cr>

" " F10 to open quickfix window
" function! ToggleQuickFix()
"     if empty(filter(getwininfo(), 'v:val.quickfix'))
"         Copen
"     else
"         cclose
"     endif
" endfunction

" nnoremap <silent> <F10> :call ToggleQuickFix()<cr>

" " fzf config
nnoremap <leader>O :Clap filer<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr>
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

command! LS call fzf#run(fzf#wrap({'source': 'cat ~/docs/bookmarks'}))

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bd' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

" " buffer/window navigation
nnoremap <Tab> :bn<cr>
nnoremap <S-Tab> :bp<cr>

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost .Xresources,xresources,xdefaults execute "AsyncRun xrdb %"
" Restart awesomewm when awesome config is updated
autocmd BufWritePost */.config/awesome/*.lua execute "AsyncRun echo 'awesome.restart()' | awesome-client"
" Restart picom when picom config is updated
autocmd BufWritePost */.config/picom/picom.conf execute "AsyncRun killall -q picom;picom --config  $HOME/.config/picom/picom.conf"
" Rebuild font cache when you change font config
autocmd BufWritePost */.config/fontconfig/fonts.conf execute "AsyncRun fc-cache -rv"

" Command to set the current directory to the dir where the current file is
command! SetCDToFileDir cd %:p:h
nnoremap <leader>W :SetCDToFileDir<cr>

"open link in browser
function! OpenLink(link)
  let l:the_command = "AsyncRun xdg-open \"" . a:link  . "\" &"
  " l:the_command = shellescape(l:the_command)
  execute escape(l:the_command,'%#')
endfunction
nmap <leader><space> yiW:call OpenLink("<c-r>"")<cr>

" Autoload sessions created by tpope's vim-obsession when starting Vim.
augroup sourcesession
        autocmd!
        autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END

" Insert semicolon at EOL
nnoremap <leader>; A;<esc>


" " Bufferline setup
lua <<EOF
require'bufferline'.setup{
  options = {
    always_show_bufferline = false
  }
}
EOF

" " command to turn off syntax highlighting. disables TS, normal vim syntax and 
" "    reenables background transparency
function! TurnOffSyntaxHighlighting()
  syntax off
  execute "TSDisable highlight"

  highlight Normal ctermbg=none guibg=NONE
  highlight LineNr ctermbg=none guibg=NONE
  highlight Folded ctermbg=none guibg=NONE
  highlight NonText ctermbg=none guibg=NONE
  highlight SpecialKey ctermbg=none guibg=NONE
  highlight VertSplit ctermbg=none guibg=NONE
  highlight SignColumn ctermbg=none guibg=NONE
  highlight CursorColumn ctermbg=NONE guibg=NONE
  highlight CursorLine ctermbg=NONE guibg=NONE
  highlight CursorLineNr ctermbg=NONE guibg=NONE
  highlight clear LineNr
  highlight clear SignColumn
endfunction

command! TurnOffSyntaxHighlighting execute TurnOffSyntaxHighlighting()

" execute TurnOffSyntaxHighlighting()

"dap config

lua << EOF
local dap = require('dap')
dap.adapters.rust = {
type = 'executable',
      attach = {
        pidProperty = "pid",
        pidSelect = "ask"
      },
      command = 'lldb-vscode', -- my binary was called 'lldb-vscode-11'
      env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
      },
      name = "lldb"
}
EOF


" set up debugging (built in)

let g:termdebug_wide = 50
function! DebugRustBegin(exe) 
  hi debugPC term=reverse ctermbg=darkblue guibg=darkblue
  hi debugBreakpoint term=reverse ctermbg=red guibg=red
  set signcolumn=yes
  packadd termdebug
  let g:termdebugger="rust-gdb"
  execute "Termdebug " . a:exe
endfunction

function! HideSignColumn()
  set signcolumn=no
endfunction
command! HideSignColumn call HideSignColumn()

" ":Over, :Step, :Continue, :Stop, :Evaluate
nnoremap <leader>ds :Step<cr>
nnoremap <leader>do :Over<cr>
nnoremap <leader>dc :Continue<cr>
nnoremap <leader>dS :Stop<cr>
nnoremap <leader>db :Break<cr>
nnoremap <leader>dC :Clear<cr>
nnoremap <leader>dr :Run<cr>
nnoremap <leader>de :Evaluate<cr>

command! DebugChess execute DebugRustBegin("target/debug/chess")


" change the terrible default map to exit terminal mode
tnoremap <c-e><c-t> <C-\><C-n>

" show current function in status line
function! CurrentFunction()
    let currentFunctionSymbol = get(b:, 'coc_current_function', '')
    return currentFunctionSymbol !=# '' ? '|' . currentFunctionSymbol : ''
endfunction

"status line
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ NVIM\ 
set statusline+=%#StatusLine#
set statusline+=\ %f\ %m\ %r\ 
set statusline+=%{CurrentFunction()}
set statusline+=%=
set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

"vista config
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = 60
let g:vista_fzf_preview = ['right:50%']
let g:vista_ignore_kinds = ["EnumMember", "Field", "TypeParameter"]
let g:vista_close_on_jump = 1
let g:vista_keep_fzf_colors = 1
let g:vista_echo_cursor = 0
let g:vista_echo_cursor_strategy = "floating_win"
let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]
nnoremap <leader>v :Vista!!<cr>
nnoremap <leader>V :Vista finder<cr>

" " vim fugitive config
nnoremap <leader>Gs :Git<cr>

" " session to remember camelcase globals
set sessionoptions+=globals

" " location list mappings
nnoremap <leader>ln :lnext<cr>
nnoremap <leader>lp :lprevious<cr>
nnoremap <leader>lf :lfirst<cr>
nnoremap <leader>ll :llast<cr>
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lc :lclose<cr>

" " quickfix list mappings
nnoremap <leader>qf :cfirst<cr>
nnoremap <leader>ql :clast<cr>

" " hop.nvim config
nnoremap s :HopWord<cr>

" " clear trailing whitespace
nnoremap <leader>tw :%s/\s\+$//e<cr>

" " toggle nowrap
nnoremap <leader>nw :set nowrap!<cr>

" " nvim tree config
nnoremap <leader>f :NvimTreeToggle<CR>
