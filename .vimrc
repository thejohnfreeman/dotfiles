" Maintainer: John Freeman

" Install vim-plug as the plugin manager:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

set nocompatible

" With the base16-tomorrow colorscheme,
" warnings in JSON are low contrast gray-on-black.
let g:vim_json_warnings = 0

let g:polyglot_disabled = ['typescript', 'tsx']

call plug#begin()
" Better default settings for Vim.
Plug 'tpope/vim-sensible'
" Make '.' work for plugins.
Plug 'tpope/vim-repeat'
" [q / ]q = prev / next quickfix.
Plug 'tpope/vim-unimpaired'
" Text objects for parameters/arguments.
" Plug 'wellle/targets.vim'
" ALL the color schemes!
Plug 'flazz/vim-colorschemes'
" Color-code matching delimiters.
Plug 'luochen1990/rainbow'
" Highlight variables in different colors.
Plug 'jaxbot/semantic-highlight.vim'
" ALL the languages!
" Syntax files are loaded on-demand, and the list of language-specific plugins
" is curated and regularly updated.
Plug 'sheerun/vim-polyglot'
" Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'tsx'] }
" Fuzzy search everywhere.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Remind me of register contents when I press `"`.
Plug 'junegunn/vim-peekaboo'
" Remind me of mark targets when I press ```.
Plug 'Yilin-Yang/vim-markbar'
" Expanding visual selection.
Plug 'terryma/vim-expand-region'
" Context-sensitive absolute and relative line numbering.
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Incremental search.
Plug 'haya14busa/incsearch.vim'
" Seamless C-h/j/k/l between vim windows and tmux panes.
Plug 'christoomey/vim-tmux-navigator'
" gc to un/comment target or selection; gcc to un/comment line.
Plug 'tpope/vim-commentary'
" Case-preserving substitution.
Plug 'tpope/vim-abolish'
" yank-then-surround-with ('ys'), change ('cs'), or delete ('ds') delimiters.
Plug 'tpope/vim-surround'
" Lightweight, orthogonal status line.
Plug 'itchyny/lightline.vim'
" Almost a GUI for Git.
" Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
" TRIAL: A better file explorer.
Plug 'tpope/vim-vinegar'
" Use tmux as a REPL.
Plug 'jpalardy/vim-slime'
" Search file contents in the quickfix list.
Plug 'mileszs/ack.vim'
" Language Server Client.
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
" Mark diff in the gutter.
Plug 'mhinz/vim-signify'
" Tag bar.
Plug 'liuchengxu/vista.vim'
" Tame the quickfix window.
Plug 'romainl/vim-qf'
Plug 'n3wjack/logsyntax.vim'
call plug#end()

" DONE: typescript-vim vs yats.vim vs LanguageClient-neovim vs deoplete.nvim
" DONE: vim-gitgutter + terminus OR vim-signify (mark diff in gutter)
"       vim-gitgutter is generally regarded as slow.
" DONE: nathanaelkane/vim-indent-guides
"       1. Doesn't cross blank lines.
"       2. Doesn't play well with `cursorline`.
" TODO: vim-stay (preserve buffer state)
" TODO: Konfekt/FastFold + tmhedberg/simpylfold (fold Python)
" TODO: twinside/vim-haskellfold
" TODO: majutsushi/tagbar OR liuchengxu/vista.vim
" TODO: kana/vim-textobj-user ("argument" text objects?)
" TODO: rstacruz/sparkup OR emmetio/emmet (HTML completion and editing)
" TODO: xolox/vim-session
" TODO: rbong/flog
" TODO: ajh17/VimCompletesMe
" TODO: vim-autoformat/vim-autoformat


" Be quiet.
set visualbell


" Mappings
" ========

" Space is your <Leader>.
" https://github.com/sheerun/blog/blob/master/_posts/2014-03-21-how-to-boost-your-vim-productivity.markdown
let mapleader=' '
nnoremap <Leader>/ :Ack!
" Fuzzy search for a file.
nnoremap <Leader>f :FZF<Enter>
" Make a Markdown link.
vnoremap <Leader>l c[<C-R>"]()<Esc>
" Make inline code in Markdown.
vnoremap <Leader>` c`<C-R>"`<Esc>
nnoremap <Leader>` ysiw`
" Make bold text in Markdown.
vnoremap <Leader>8 c**<C-R>"**<Esc>
nnoremap <Leader>8 ysiw*l.
" Search tags.
nnoremap <Leader>t :Vista finder fzf:vim_lsp<Enter>
" Save.
nnoremap <Leader>w :w<Enter>
" Quit.
nnoremap <Leader>q :q<Enter>
" Format paragraph.
nnoremap <Leader>= gqap

nnoremap q] :cnext<Enter>
nnoremap q[ :cprev<Enter>

" Make Escape work in terminal mode.
" https://vi.stackexchange.com/a/4922/1176
:tnoremap <Esc> <C-\><C-n>

" More memorable navigation.
nnoremap <silent> <Backspace> <C-O>
nnoremap <silent> <S-Backspace> <C-I>
nnoremap <silent> <C-.> <C-I>
nnoremap <silent> <C-,> <C-O>
nnoremap <silent> <Right> <C-I>
nnoremap <silent> <Left> <C-O>

" Enable vim-slime from insert mode.
inoremap <silent> <C-C><C-C> <C-O>:SlimeSend<Enter>

" Expand and shrink visual selections.
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" Make Y behave as expected.
nnoremap Y y$

" Do what I mean, not what I say.
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
nnoremap q: :q
command! Q q
command! W w
command! Wq wq

" Language Server Mappings
" ------------------------

" vim-lsp
" .......

nnoremap <silent> <F1>
  \ @=getwinvar(winnr() + 1, "&previewwindow")
  \ ? ":pclose" : ":LspHover"<Enter><Enter>
set keywordprg=:LspHover
nmap <Leader>d <Plug>(lsp-definition)
nmap <Leader>r <Plug>(lsp-references)
nmap <F7>      <Plug>(lsp-references)
nmap gd        <Plug>(lsp-definition)
nmap gD        <Plug>(lsp-peek-definition)
nmap <F2>      <Plug>(lsp-rename)
nmap ]d        <Plug>(lsp-next-diagnostic)
nmap [d        <Plug>(lsp-previous-diagnostic)
nmap ]e        <Plug>(lsp-next-error)
nmap [e        <Plug>(lsp-previous-error)
nmap ]w        <Plug>(lsp-next-warning)
nmap [w        <Plug>(lsp-previous-warning)
nmap ]r        <Plug>(lsp-next-reference)
nmap [r        <Plug>(lsp-previous-reference)

" Protect these mappings from vim-unimpaired.
let g:nremap = {"[e": "", "]e": "", "[r": "", "]r": ""}


" Language Server
" ===============

" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_enabled = 0

" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Clangd
if executable('clangd')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '--background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Python
if executable('pyls')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('rls')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif

if executable('typescript-language-server')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['javascript', 'typescript', 'typescript.tsx'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    " setlocal omnifunc=lsp#complete
    " setlocal signcolumn=yes
endfunction

augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

augroup lsp_folding
  autocmd!
  autocmd FileType javascript setlocal
        \ foldmethod=expr
        \ foldlevel=99
        \ foldexpr=lsp#ui#vim#folding#foldexpr()
        \ foldtext=lsp#ui#vim#folding#foldtext()
augroup end

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('vim-lsp.log')


" Completion
" ==========

" Return true if all the characters to the left of the cursor are whitespace.
function! CursorAfterOnlyWhitespace()
  return strcharpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
endfunction

function! CursorAfterIdentifier()
  " =~? is "matches regex, ignoring case"
  return strcharpart(getline('.'), 0, col('.') - 1) =~? '[a-z_]\+[a-z0-9_]*$'
endfunction

" let g:asyncomplete_auto_popup = 0
inoremap <expr> <silent> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ CursorAfterOnlyWhitespace() ? "\<Tab>" :
  \ asyncomplete#force_refresh()
inoremap <expr> <silent> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
inoremap <expr> <silent> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

" Use the popup menu for insert-mode completions.
set completeopt=menu
" Use the popup menu even when there is only one match.
set completeopt+=menuone
" Show extra information about the completion in the preview window.
set completeopt+=preview
" Do not insert text for a match until one is selected.
set completeopt+=noselect
" Do not automatically select a match in the menu.
set completeopt+=noinsert


" Registers
" =========

" Yank to and paste from the system clipboard by default.
" On Linux, `unnamed` goes to `XA_PRIMARY`,
" and `unnamedplus` goes to `XA_CLIPBOARD`.
" `XA_PRIMARY` stores the mouse selection.
" VMware Workstation syncs the Windows clipboard with XA_PRIMARY.
set clipboard=unnamed

" Do not overwrite the default register when changing text.
noremap c "_c
noremap cc "_cc
noremap C "_C

" Do not overwrite the default register when pasting over a selection.
function! PasteButPreserve()
  if col('.') == col('$') - 1
    return '"_dp'
  else
    return '"_dP'
  endif
endfunction
xnoremap <expr> p PasteButPreserve()
xnoremap <expr> P PasteButPreserve()


" Display
" =======

" For performance.
set lazyredraw

" We show the mode in the status line instead of the command line.
set noshowmode

" Highlight the row I am on.
set cursorline
" Highlight the linebreak column.
set colorcolumn=+1

" Use relative numbers for every line except mine.
set relativenumber
set number

" Subtly highlight some invisible characters.
set list
set listchars-=trail:-
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Show trailing whitespace only when not in insert mode.
augroup trailing
  autocmd!
  autocmd InsertEnter * :set listchars-=trail:⌴
  autocmd InsertLeave * :set listchars+=trail:⌴
augroup END

let g:signify_vcs_list = ['git']

let g:vista_default_executive = 'vim_lsp'


" Formatting
" ==========

set expandtab
" Separate sentences with only one space when joining lines.
set nojoinspaces
set shiftwidth=2
set softtabstop=2
set tabstop=2
set textwidth=78

" Insert comment leader when pressing <Enter> in Insert mode.
set formatoptions+=r
" Insert comment leader when opening a new line in Normal mode.
set formatoptions+=o
" Do not wrap lines that were long when Insert mode was entered.
set formatoptions+=l
" Break before a one-letter word instead of after.
set formatoptions+=1

" Make vim-commentary use C++-style comments instead of C-style comments.
" https://github.com/tpope/vim-commentary/issues/15#issuecomment-23127749
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s shiftwidth=4 tabstop=4

" function! FormatBuffer()
"   silent !git diff --relative -U0 % | clang-format-diff -p1 -i
"   edit
" endfunction

" function! ConfigureCpp()
"   augroup format
"     autocmd!
"     " Must be nested for :edit to fire BufEnter.
"     autocmd BufWritePost,FileWritePost * nested call FormatBuffer()
"   augroup END
" endfunction

" TODO: Move this to an ftplugin directory.
" augroup cpp
"   autocmd!
"   autocmd FileType cpp call ConfigureCpp()
" augroup END

" If you are using Poetry, start a shell in Poetry's virtual environment to
" enable Python fixers.


" Search
" ======

set hlsearch

" Clear the highlight if I spam <Escape> (i.e. press it in normal mode).
" https://stackoverflow.com/questions/11940801/mapping-esc-in-vimrc-causes-bizarre-arrow-behaviour/16027716#16027716
" TODO: Presently broken when tmux is not running.
" if has('gui_running')
"   nnoremap <Esc> :nohlsearch<Enter><Esc>
" else
"   augroup no_highlight
"     autocmd TermResponse * nnoremap <Esc> :nohlsearch<Enter><Esc>
"   augroup END
" end

" Search is case-insensitive unless an uppercase letter is used.
set ignorecase
set smartcase

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

if executable('ag')
  " Do not use --vimgrep. It creates an entry for every match on a line which
  " makes :cdo do the wrong thing.
  let g:ackprg = 'ag'
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif


" Sessions & Windows
" ==================

" Put the swap file next to the opened file.
set directory=.

" Do not keep a backup file (use version control instead).
set nobackup
" Turn off safe-write for Parcel.
" https://github.com/parcel-bundler/parcel/issues/382#issuecomment-353644874
set nowritebackup

" Match tmux's split direction.
set splitright
set splitbelow

" Resize splits when window resized.
autocmd VimResized * :wincmd =

" Return to where we left the file (unless it is a Git commit message).
augroup cursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute "normal! g'\"zzzv" |
        \ endif
augroup END

" augroup quickfix
"   autocmd!
"   " Open QuickFix hits in the previous window.
"   " https://vi.stackexchange.com/a/13377/1176
"   autocmd FileType qf nnoremap <buffer> <Enter> :exe 'wincmd p \| '.line('.').'cc'<Enter>
"   autocmd FileType qf nnoremap <buffer> <BS> <C-w><C-p>
"   autocmd FileType qf nnoremap <buffer> <Esc> <C-w><C-p>
" augroup END


" vim-slime
" =========

if !empty($TMUX)
  let g:slime_target = 'tmux'
  let g:slime_default_config = {
        \ 'socket_name': split($TMUX, ',')[0],
        \ 'target_pane': ':.2'
        \}
endif


" Reload
" ======

" `Reload()` is a function to reload the .vimrc to get a new list of plugins,
" install all the plugins, then reload the .vimrc again to load the new
" plugins. It has some scaffolding with the global variable `g:reloading` so
" that it can be redefined, but not when it is already running.

if !exists('g:reloading')
  let g:reloading = 0
endif

if !g:reloading
  function! Reload()
    let g:reloading = 1
    :source $MYVIMRC
    :PlugInstall
    :sleep 1
    :execute 'quit'
    :execute "normal! \<C-w>\<C-p>"
    :source $MYVIMRC
    let g:reloading = 0
  endfunction
endif

command! Reload :call Reload()


" Colors
" ======

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " https://sunaku.github.io/vim-256color-bce.html
  " http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
set background=dark
try
  colorscheme Tomorrow-Night
catch
endtry

" Enable rainbow delimiters.
let g:rainbow_active = 1

let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'inactive': { 'left': [['relativepath', 'modified']] },
  \ }

let g:lightline.active = {
  \ 'left': [
  \   ['mode'],
  \   ['relativepath', 'modified'],
  \ ],
  \ 'right': [
  \   ['lineinfo'],
  \   ['percent'],
  \   ['fileformat', 'fileencoding', 'filetype'],
  \ ],
  \ }

let g:rainbow_conf = {
  \ 'ctermfgs':
    \ ['lightmagenta', 'lightblue', 'lightgreen', 'lightyellow', 'lightred']
  \}


" Projects
" ========

" Let me override Vim settings within a project by searching for a `vimrc`.
function! ConfigureVim()
  try
    let l:vimrc = findfile('vimrc', expand('%:p:h') . ';')
    exec 'source ' . l:vimrc
    echo 'sourced ' . l:vimrc
  catch
  endtry
endfunction

augroup vimrc
  autocmd!
  autocmd BufRead * call ConfigureVim()
augroup END
