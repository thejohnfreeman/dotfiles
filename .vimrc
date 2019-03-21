" Maintainer: John Freeman

" Install vim-plug as the plugin manager:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

set nocompatible

" With the base16-tomorrow colorscheme,
" warnings in JSON are low contrast gray-on-black.
let g:vim_json_warnings = 0

let g:polyglot_disabled = ['typescript', 'tsx']
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1

call plug#begin()
" Better default settings for Vim.
Plug 'tpope/vim-sensible'
" Make '.' work for plugins.
Plug 'tpope/vim-repeat'
" [q / ]q = prev / next quickfix.
Plug 'tpope/vim-unimpaired'
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
Plug 'leafgarland/typescript-vim'
" Fuzzy search everywhere.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Remind me of register contents when I press `"`.
Plug 'junegunn/vim-peekaboo'
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
Plug 'tpope/vim-fugitive'
" TRIAL: A better file explorer.
Plug 'tpope/vim-vinegar'
" Use tmux as a REPL.
Plug 'jpalardy/vim-slime'
" Search file contents in the quickfix list.
Plug 'mileszs/ack.vim'
" Asynchronous Lint Engine.
Plug 'w0rp/ale'
" Mark diff in the gutter.
Plug 'mhinz/vim-signify'
call plug#end()

" DONE: typescript-vim vs yats.vim vs LanguageClient-neovim vs deoplete.nvim
" TODO: vim-gitgutter + terminus OR vim-signify (mark diff in gutter)
" TODO: vim-stay (preserve buffer state)
" TODO: Konfekt/FastFold + tmhedberg/simpylfold (fold Python)
" TODO: twinside/vim-haskellfold
" TODO: majutsushi/tagbar
" TODO: kana/vim-textobj-user ("argument" text objects?)
" TODO: rstacruz/sparkup OR emmetio/emmet (HTML completion and editing)
" TODO: xolox/vim-session
" TODO: rbong/flog


" Be quiet.
set visualbell


" Mappings
" ========

" Space is your <Leader>.
" https://github.com/sheerun/blog/blob/master/_posts/2014-03-21-how-to-boost-your-vim-productivity.markdown
let mapleader=' '
nnoremap <Leader>/ :Ack!
" Fuzzy search for a file.
nnoremap <Leader>f :FZF<CR>
" Save.
nnoremap <Leader>w :w<CR>
" Quit.
nnoremap <Leader>q :q<CR>

" Step through errors from ALE.
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
" Protect these mappings from vim-unimpaired.
let g:nremap = {"[e": "", "]e": ""}

" Return true if all the characters to the left of the cursor are whitespace.
function! CursorAfterOnlyWhitespace()
  return strcharpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
endfunction

function! TabComplete(complete, indent)
  if pumvisible()
    " Tab through completions.
    return a:complete
  endif
  if CursorAfterOnlyWhitespace()
    " Indent.
    return a:indent
  endif
  " Find completions.
  return "\<C-\>\<C-O>:ALEComplete\<CR>"
endfunction

inoremap <silent> <Tab> <C-R>=TabComplete("\<lt>C-N>", "\<lt>Tab>")<CR>
inoremap <silent> <S-Tab> <C-R>=TabComplete("\<lt>C-P>", "\<lt>S-Tab>")<CR>

" Automatic completion replaces |completeopt| before opening the omnicomplete
" menu with <C-x><C-o>. In some versions of Vim, the value set for the option
" will not be respected. If you experience issues with Vim automatically
" inserting text while you type, set the following option in vimrc, and your
" issues should go away.
set completeopt=menu,menuone,preview,noselect,noinsert

" Language Server functions.
nmap <silent> <F1> @=getwinvar(winnr() + 1, "&previewwindow") ? ":pclose" : ":ALEHover"<CR><CR>
nmap <silent> <F2> :ALEGoToDefinition<CR>
imap <silent> <F2> <Esc><F2>
nmap <silent> <F7> :ALEFindReferences<CR>

" Go back with Backspace.
nnoremap <silent> <Backspace> <C-O>

" Enable vim-slime from insert mode.
inoremap <silent> <C-C><C-C> <C-O>:SlimeSend<CR>

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

" Do not overwrite the default register when pasting over selection.
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()


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

function! ConfigureCpp()
  let l:clang_format_config = findfile('.clang-format', expand('%:p:h') . ';')
  if l:clang_format_config != ''
    let b:ale_fixers = ['clang-format']
    let b:ale_c_clangformat_options = '-assume-filename ' . expand('%:p')
  endif
endfunction

augroup cpp
  autocmd!
  autocmd FileType cpp call ConfigureCpp()
augroup END

let g:ale_linters = {
      \  'cpp': ['ccls'],
      \}
let g:ale_fixers = {
      \  'cpp': [],
      \  'css': ['prettier'],
      \  'javascript': ['prettier'],
      \  'typescript': ['prettier'],
      \}
let g:ale_fix_on_save = 1


" Search
" ======

set hlsearch

" Clear the highlight if I spam <Escape> (i.e. press it in normal mode).
" https://stackoverflow.com/questions/11940801/mapping-esc-in-vimrc-causes-bizarre-arrow-behaviour/16027716#16027716
" TODO: Presently broken when tmux is not running.
" if has('gui_running')
"   nnoremap <Esc> :nohlsearch<CR><Esc>
" else
"   augroup no_highlight
"     autocmd TermResponse * nnoremap <Esc> :nohlsearch<CR><Esc>
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
augroup restore_mark
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g'\"zzzv" |
        \ endif
augroup END


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
  \ 'active': { 'left': [['mode'], ['relativepath', 'modified']] },
  \ }

let g:rainbow_conf = {
  \ 'ctermfgs':
    \ ['lightmagenta', 'lightblue', 'lightgreen', 'lightyellow', 'lightred']
  \}
