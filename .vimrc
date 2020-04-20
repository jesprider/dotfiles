"===============================================================================
" Pre-install
"===============================================================================
if !isdirectory($HOME . "/.vim-swp")
    call mkdir($HOME . "/.vim-swp/undo", "p", 0700)
    call mkdir($HOME . "/.vim-swp/swap", "p", 0700)
endif


"===============================================================================
" Plugins
"===============================================================================
call plug#begin()

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" Things you can do with fzf and Vim.
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Theme
Plug 'morhetz/gruvbox'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Comment stuff out
Plug 'tpope/vim-commentary'
"
" Vim sugar for the UNIX shell commands that need it the most.
Plug 'tpope/vim-eunuch'
"
" Combine with netrw to create a delicious salad dressing
Plug 'tpope/vim-vinegar'

" Git diff in the gutterv
Plug 'airblade/vim-gitgutter'

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'

" Syntax highlighting for javascript
Plug 'pangloss/vim-javascript'

" Syntax highlighting for vue files
Plug 'posva/vim-vue'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" A Vim plugin that manages your tag files
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

"===============================================================================
" Editor configuraton
"===============================================================================
set encoding=utf-8

" Theme
let g:gruvbox_contrast_light='hard'
set background=light
colorscheme gruvbox

" Enable syntax highlighting
syntax on

" Make Vim more useful
set nocompatible

" Undo and swap files
set nobackup
set undodir=~/.vim-swp/undo
set undolevels=1000 undoreload=10000
set undofile
set directory=~/.vim-swp/swap/

" Displaying status line always
set laststatus=2

" Enable line numbers
set number

" Enhance command-line completion
set wildmenu
set wildmode=list:longest,full
set wildignore=*.pyc,*.pyo,*.o

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
set noshowmode

" Show the filename in the window titlebar
set title

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" if hidden is not set, TextEdit might fail.
set hidden

" always show signcolumns
set signcolumn=yes

"===============================================================================
" Lightline configuration 
"===============================================================================
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

"===============================================================================
" Syntax highlighing and autocomplete
"===============================================================================
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-vetur',
  \ 'coc-yaml',
  \ 'coc-python',
  \ 'coc-emmet',
  \ 'coc-snippets',
  \ 'coc-tailwindcss',
  "\ 'coc-pairs',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_files_options = ['--preview=head -c 1024 {}', '--preview-window=right:30%']

" Ctags
let g:gutentags_exclude_filetypes = [
  \ 'node_modules',
  \ ]
"===============================================================================
" Key bindings
"===============================================================================

" Enter empty line without entering edit mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Refresh syntax highlighting
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" FZF remapping
nnoremap <C-p> :Files<Cr>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>

" Strip trailing whitespace (\ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Copying to clipboard
noremap <Leader>y :w !pbcopy<CR><CR>
noremap <Leader>p :r !pbpaste<CR><CR>

" Tags
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
