" Programs Required for some stuff:
" - (if on WSL2) win32yank (scoop install win32yank (on windows)) - for clipboard
" - rg
" - LSP servers = rust-analyzer, clangd, typescript-language-server
" - (for COQ) python3-venv (apt install --yes -- python3-venv)
" - (for cute block comments) figlet and boxes

lua <<EOF

-- reload lucy
require('plenary.reload').reload_module('lucy', true)

require('packer').startup(function()
   use 'wbthomason/packer.nvim'
   use 'kjssad/quantum.vim'
   use 'sheerun/vim-polyglot'
   use 'tpope/vim-commentary'
   use 'skywind3000/asyncrun.vim'
   use 'tpope/vim-obsession'
   use 'kyazdani42/nvim-web-devicons'
   use 'kyazdani42/nvim-tree.lua'
   use 'akinsho/nvim-bufferline.lua'
   use 'tpope/vim-fugitive'
   use 'phaazon/hop.nvim'
   use {
     'nvim-telescope/telescope.nvim',
     requires = { {'nvim-lua/plenary.nvim'} }
   }
   use 'liuchengxu/vista.vim'
   use 'neovim/nvim-lspconfig'
   use 'simrat39/rust-tools.nvim'
   use {'ms-jpq/coq_nvim', branch = 'coq'}
   use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
   use 'windwp/nvim-autopairs'
   use 'ray-x/lsp_signature.nvim'

-- Ts stuff
   use 'jose-elias-alvarez/null-ls.nvim'
   use 'jose-elias-alvarez/nvim-lsp-ts-utils'
   use 'tpope/vim-scriptease'
end)

EOF


"" --------  Vim Set's ----------

lua <<EOF
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.o.linespace=1
vim.o.guifont="FiraCode Nerd Font:h16"
vim.g.netrw_fastbrowse = 0
vim.o.linebreak = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.background="dark"
vim.g.mapleader = "-"
vim.o.title = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.clipboard="unnamedplus"
vim.o.tabstop=2
vim.o.shiftwidth=2
vim.o.expandtab = true
vim.o.hidden = true
vim.o.mouse='a'
vim.opt.formatoptions:remove('cro')
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff=10
vim.opt.shortmess:append('A')
vim.opt.sessionoptions:append('globals')
EOF
filetype plugin indent on

"" --------  Theming ----------
colorscheme quantum

" " modifications to quantum theme
hi StatusLine guibg=#252525 guifg=white
hi LineNr guifg=#aaaaaa
hi CursorLineNr guifg=white
hi Normal guibg=#252525
hi Visual guifg=black guibg=#e3b6e2
hi LspSignatureActiveParameter guibg=#e3b6e2 guifg=black
hi Pmenu guibg=NONE guifg=#dddddd
hi PmenuSel guibg=#e3b6e2 guifg=black
hi NormalFloat guibg=NONE guifg=#dddddd
hi VertSplit guifg=#e3b6e2

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

highlight Normal guibg=NONE ctermbg=NONE
highlight CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLineNr cterm=NONE ctermbg=NONE ctermfg=NONE
highlight clear LineNr
highlight clear SignColumn
highlight clear StatusLine

"" extra settings, uncomment them if necessary :) 
"set cursorline
"set noshowmode
set nocursorline

"" ---------- autocommands ------
lua << EOF
-- TODO: do the rest in lua like this: (uncomment)
-- local au = vim.api.nvim_create_autocmd
-- local lucyg = vim.api.nvim_create_augroup("lucy", {clear = true})
-- au("BufEnter", {callback = function() vim.bo.filetype = "text" end, pattern = "*.txt", group = lucyg})
EOF

augroup lucy
  autocmd!
  " " disable netrw (it is bad)
  au FileType netrw setl bufhidden=wipe
  au BufEnter *.txt setl filetype=text
  au BufWritePost $MYVIMRC source $MYVIMRC
  au VimResized * wincmd =
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " for transparent bg (might not be necessary)
  au ColorScheme * call AdaptColorscheme()
  au InsertEnter * set nocursorline
  au InsertLeave * set nocursorline
augroup END

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
nn <silent> <C-\> :terminal<cr>i
tno <silent> <C-\> <C-\><C-n>:bd!<cr>

"" --------  Commands ----------

function! s:cute_block_comment(text)
  execute "r !figlet " . a:text . " | boxes"
endfunction
command! -nargs=1 CuteBlockComment call s:cute_block_comment(<args>)

function! s:smol_block_comment(text)
  execute "r !echo " . a:text . " | boxes"
endfunction
command! -nargs=1 SmolBlockComment call s:smol_block_comment(<args>)

command! Scratch lua require'lucy'.makeScratch()
command! FixCompilerOutput lua require'lucy'.fix_compiler_output()

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
        virtual_text = true,
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

"" --------  Mappings and config - COQ and nvim-autopairs ----------
lua <<EOF
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { 
  auto_start= "shut-up", 
  keymap = { 
    recommended = false,
    manual_complete = "<C-Space>",
    bigger_preview = "<C-k>",
    jump_to_mark = "",
    eval_snips = "",
    ['repeat'] = "",
  }
}

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
EOF

"" --------  Mappings and config - lsp_signature ----------
lua << EOF
require "lsp_signature".setup({
   bind = true,
   handler_opts = {
      border = "rounded"
   },
})
EOF

"" --------  Mappings and config - vim-obsession ----------
" Autoload sessions created by tpope's vim-obsession when starting Vim.

augroup sourcesession
        autocmd!
        autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END
