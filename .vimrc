call plug#begin()

Plug 'Valloric/YouCompleteMe'
Plug 'tomasiser/vim-code-dark'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'w0rp/ale'
Plug 'tpope/vim-vinegar'
Plug 'posva/vim-vue'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

call plug#end()

set encoding=utf-8
set guifont=Monaco:h12
set previewheight=25

" Use the Solarized Dark theme
colorscheme codedark

" Make Vim more useful
set nocompatible

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Undo and swap files
set nobackup
set undodir=~/.vim-swp/undo
set undolevels=1000 undoreload=10000
set undofile
set directory=~/.vim-swp/swap/

" Show commands currently typing
set showcmd

" Enable line numbers
set number

" Show the cursor position
set ruler

" Enable syntax highlighting
syntax on

" Enhance command-line completion
set wildmenu
set wildmode=list:longest,full

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" To insert space characters whenever the tab key is pressed
set expandtab

" Number of space characters that will be inserted when the tab key is pressed
set tabstop=4
set softtabstop=4

" How many columns text is indented with the reindent operations (<< and >>)
set shiftwidth=4

" Enable smart and auto indents
set smarttab
set autoindent
set smartindent

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Always show status line
set laststatus=2

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

let g:ackprg = 'ag --nogroup --nocolor --column'

" FZF
noremap <C-T> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let g:ale_lint_delay = 100
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'javascript': ['eslint'],
\ 'vue': ['eslint'],
\ 'python': ['black']
\ }
nmap <leader>d <Plug>(ale_fix)

" Enter empty line without entering edit mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Refresh syntax highlighting
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

" Enables code folding for javascript based on our syntax file.
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

set foldlevelstart=20

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" ==============
" MacVim related
" ==============
set guioptions=
