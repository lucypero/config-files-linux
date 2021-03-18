" Programs Required for some stuff:
" rg

" " cool ideas to try:
" alt+w/b to move between words in variables, like you have 'unicodeLetter' and pressing alt+w would take you to the L instead of to the next word. use that plugin u used for that

" todo:
" try out native nvim lsp server, check out if the odin server can run on it, also related:
" https://github.com/neovim/nvim-lspconfig

let g:polyglot_disabled = ['odin', 'python', 'c', 'cpp', 'json']

let g:coc_global_extensions = [
\ 'coc-pyright',
\ 'coc-marketplace',
\ 'coc-lua',
\ 'coc-json',
\ 'coc-vimlsp',
\ 'coc-rust-analyzer'
\ ]

call plug#begin('~/.local/share/nvim/plugged')
" color schemes
Plug 'dracula/vim', {'as':'dracula'}
Plug 'sainnhe/gruvbox-material'
Plug 'gosukiwi/vim-atom-dark'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'nightsense/strawberry'
Plug 'kjssad/quantum.vim'
Plug 'vim-scripts/eclipse.vim'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'NLKNguyen/papercolor-theme'
" rest
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'Tetralux/odin.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'ap/vim-css-color'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-obsession'
Plug 'justinmk/vim-sneak'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/nvim-bufferline.lua'
Plug 'tpope/vim-fugitive'
" snippets
Plug 'honza/vim-snippets'

" vim-telescope. Very promising. Still not fully done yet. Does not work well with  coc :/ so i can's search symbols
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

Plug 'kana/vim-submode'
Plug 'brenopacheco/vim-hydra'
Plug 'mfussenegger/nvim-dap'

call plug#end()

" " gui config (no need for ginit.vim anymore)
set linespace=1
" set guifont=DejaVu\ Sans\ Mono:h15
set guifont=Fira\ Code:h14
" set guifont=Liberation\ Mono:h15

" " neovide config (Windows GUI)
let g:neovide_fullscreen=v:false
let g:neovide_cursor_animation_length=0
let g:neovide_cursor_trail_length=2
let g:neovide_cursor_vfx_mode = "wireframe"
let g:neovide_cursor_antialiasing=v:true

" " close netrw
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0

" "  --------- THEMING  -----------

" " Color theme config
set termguicolors
set background=dark

" " dracula settings
" let g:dracula_italic = 0
" colorscheme dracula

" gruvbox settings
" let g:gruvbox_material_disable_italic_comment = 1
" let g:gruvbox_material_enable_italic = 0
" let g:gruvbox_material_background = 'hard'
" colorscheme gruvbox-material


" " palenight settings
" colorscheme palenight
" highlight Comment guifg=#909090

" colorscheme strawberry-light
" colorscheme atom-dark
let s:current_colorscheme = 'quantum'
execute printf("colorscheme %s", s:current_colorscheme)
" colorscheme seoul256-light
" colorscheme PaperColor

" colorscheme summerfruit256

let s:transparent_bg = 1

function! ToggleTransparentBG() 
  if s:transparent_bg == -1
    execute printf("colorscheme %s", s:current_colorscheme)
  else
    highlight clear CursorLine
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
    highlight StatusLine ctermbg=NONE guibg=NONE
    highlight StatusLineNC ctermbg=NONE guibg=NONE
    highlight clear LineNr
    highlight clear SignColumn
  endif

  let s:transparent_bg = s:transparent_bg * -1
endfunction
call ToggleTransparentBG()

command! ToggleTransparentBG call ToggleTransparentBG()

" disable background override (use terminal background settings)

let mapleader = "-"

set title

set cursorline

" " line number - relative
set relativenumber

" set clipboard register to be the default register. 
" no need for <leader>p or <leader>y anymore
set clipboard=unnamedplus

" leader p for pasting what is in the "0 register (last yank that was not a delete)
nnoremap <leader>p "0p
nnoremap <leader>P "0P
vnoremap <leader>p "0p
vnoremap <leader>P "0P

" " not necessary anymore (read above)
" " " Copy to clipboard
" vnoremap  <leader>y  "+y
" nnoremap  <leader>Y  "+yg_
" nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy

" " " Paste from clipboard
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P
" vnoremap <leader>p "+p
" vnoremap <leader>P "+P

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
nnoremap <leader>s :wa <cr>

" " so that i don't need to hold shift all the time
" nnoremap ; :
" vnoremap ; :

" " " regain functionality of ; (repeat last move (f/F and t/T)
" nnoremap ; :
" nnoremap : ;
" vnoremap ; :
" vnoremap : ;

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
noremap <leader>q :bp\|bd #<cr>

" switch header file <-> implementation file
nnoremap <leader>h :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Disable that annoying swap file warning
set shortmess+=A

" " Plugin Configuration ---

" " vim-ripgrep config
nnoremap <leader>r :Rg --no-ignore 
let g:rg_highlight = 1

" " shortcut for searching whatever is in the copy registry
nnoremap <C-3> /<C-R>0<cr>

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

" " Visual movement by default
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" " Show current function name
fun! ShowFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun
map <leader>f :call ShowFuncName() <CR>

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


" ----------- Odin stuff -----------

let s:odin_location = 'C:\Users\Admin\dev\third_party\Odin'

" odin errorformat
set errorformat+=%f(%l:%c)\ %m

" odin - go to definition
fun! OdinGoToDef(identif)
  let l:the_command = 'Rg --no-ignore -g "*.odin" ^^\s*' . a:identif . '\s*:: . ' . s:odin_location
  let l:the_command .= ' ' . s:odin_location . '\shared'
  " echo the_command
  execute the_command
endfun
nnoremap <leader>gd yiw:call OdinGoToDef("\\b<c-r>+\\b")<cr>

" odin - search odin code
fun! OdinSearch(thing)
  echo 'hadwhdaw'
  let l:the_command = 'Rg -g "*.odin" ' . a:thing . ' ' . s:odin_location
  echo the_command
  execute the_command
endfun
nnoremap <leader>go :call OdinSearch("")<left><left>

" odin - list all proc definitions in buffer
fun! OdinProcs(only_in_buffer)
    let l:the_command = 'Rg --no-ignore ^^\s*\w*\s*::\s*(?:inline)?\s*proc\('
    if a:only_in_buffer
      let l:the_command .= ' %'
    endif
    " echo the_command
    execute the_command
endfun
" keymap done in the language dependent mappings section

" odin - list all structs definitions in buffer
fun! OdinStructs(only_in_buffer)
    let l:the_command = 'Rg --no-ignore ^^\s*\w*\s*::\s*struct'
    if a:only_in_buffer
      let l:the_command .= ' %'
    endif
    " echo the_command
    execute the_command
endfun
nnoremap <leader>gs :call OdinStructs(1)<cr>
nnoremap <leader>gS :call OdinStructs(0)<cr>


" ----------- / Odin stuff -----------

" super comment - code area separator
nmap <leader>GC o ----------- CODEAREA -----------<esc>gccfCce

" list all code area separators
fun! ListCodeSeparators()
    let l:the_command = 'Rg --no-ignore "// ----------- .* -----------" %'
    " echo the_command
    execute the_command
endfun
" nnoremap <leader>ca : call ListCodeSeparators()<cr>


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


" ----------- Filetype specific bindings -----------

" odin
au FileType odin nnoremap <buffer> <leader>gf :call OdinProcs(1)<cr>
au FileType odin nnoremap <buffer> <leader>gF :call OdinProcs(0)<cr>

" code fold config:
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" to get rid of the ^M's that sometimes show up for some reason
nnoremap <leader>Rm :e ++ff=dos<cr>

" close buffer quickly
nnoremap <c-q> :q<cr>

" quit vim
nnoremap <leader><c-q> :qa<cr>


" ----------- Plugin Config: vim-clap  -----------
" I went back to fzf haha

" vim-clap config
let g:clap_insert_mode_only = v:true
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --no-ignore --smart-case'
let g:clap_layout = { 'relative': 'editor' }

let g:clap_provider_files_no_ignore = {
   \ 'id': 'files_no_ignore',
   \ 'source': 'rg --files --no-ignore',
   \ 'sink': 'e',
   \ }

" vim-clap mappings
" nnoremap <leader>O :Clap filer<cr>
" nnoremap <leader>o :Clap files_no_ignore<cr>
" nnoremap <leader>b :Clap buffers<cr>
" nnoremap <leader>R :Clap grep<cr>


" ----------- Plugin Config: CoC -----------

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
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
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
nnoremap <leader>ca :call ToggleAutoTriggerCompletion()<cr>

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
imap <C-j> <Plug>(coc-snippets-expand-jump)

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
" nnoremap <leader>gR :call GetRuleDefinition("
" nnoremap <leader>gr yiw:call GetRuleDefinition("<c-r>+")<cr>

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

function! s:run_project()	
  execute "wa"	
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

" test rust project
command! Test execute "AsyncRun cargo test"

"async run way
if has("win32")	
noremap <silent> <F8> :wa<cr>:AsyncRun build.bat<cr>	
endif	
if has("unix")	
noremap <silent> <F8> :call <sid>run_project()<cr>
endif	

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
nnoremap <leader>R :Rg 
let g:fzf_preview_window = []

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
nnoremap <leader>k :bp<cr>
nnoremap <leader>j :bn<cr>

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


" Lf.vim config
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory
nnoremap <leader>F :Lf<cr>

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


" " sneak.vim config
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

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


" vim-submode config
function! Submode_test() 
  echomsg 'hello!'
endfunction

call submode#enter_with('debug-mode', 'n', '', '<leader>ge')
call submode#leave_with('debug-mode', 'n', '', '<leader>gE')
call submode#map('debug-mode', 'n', '', 'h', ':echomsg "hello"<cr>')

" vim-hydra config


function Hide_hydra(height, width)
  return { 'row': 0, 'col': 0 }
endfunction

let s:example_hydra =
            \ {
            \   'name':        'example',
            \   'title':       'Example hydra',
            \   'show':        'none',
            \   'exit_key':    "q",
            \   'feed_key':    v:true,
            \   'foreign_key': v:true,
            \   'position': 'Hide_hydra',
            \   'keymap': [
            \     {
            \       'name': 'Debug',
            \       'keys': [
            \         ['c', 'echomsg "continuing.."',                     'call Submode_test()'],
            \         ['n', 'echomsg "stepping to next line.."',                     'call Submode_test()'],
            \       ]
            \     },
            \   ]
            \ }

silent call hydra#hydras#register(s:example_hydra)

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
  let termdebugger="rust-gdb"
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
