filetype off
syntax on

"
set termguicolors
set background=dark
set nocompatible
set incsearch
set hlsearch
set shiftwidth=2
set number
set runtimepath+=~/.vim/
set scrolloff=5
set noswapfile
set nowritebackup
set nobackup
set hidden
set switchbuf=useopen
set ignorecase
set smartcase
set history=10000
set showmatch
set smartindent
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start
set clipboard=unnamed
set autoread
set diffopt+=vertical
set mouse=a
set cursorline
set signcolumn=yes " always show signcolumn for gitgutter
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" doulbe ESC should clear search result highlight
nnoremap <ESC><ESC> :noh<CR>