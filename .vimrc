if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'w0rp/ale'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-vinegar'
Plug 'pangloss/vim-javascript'
Plug 'Valloric/YouCompleteMe'
Plug 'posva/vim-vue'

call plug#end()

colorscheme codedark

set noswapfile

set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set shiftround
set number
set backspace=2 " make backspace work like most other programs
set incsearch " highlight search as you type
"set cursorline " highlight the line you're currently on
set lazyredraw
set nocursorline

set laststatus=2
set clipboard=unnamed
set ignorecase
set smartcase
set hlsearch

let g:ale_completion_enabled = 1
let g:ale_fixers = {
  \ 'javascript': ['eslint'],
  \ 'vue': ['eslint']
  \ }
