filetype off
syntax on

"
set termguicolors
set background=dark
set nocompatible
set whichwrap=b,s,[,],,~
set incsearch
set wildmenu wildmode=list:full
set hlsearch
set modeline
set shiftwidth=2
set number
set laststatus=2
set t_Co=256
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
set ttimeout
set ttimeoutlen=0
"set listchars=tab:▹␣
set list
set lazyredraw          " Wait to redraw
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
set noshowmatch         " Don't match parentheses/brackets
set nocursorline        " Don't paint cursor line
set nocursorcolumn      " Don't paint cursor column
set exrc
set secure
set autoread
set diffopt+=vertical
set guifont=Menlo-Regular:h14
set mouse=a
set undodir=~/.undo

"
runtime! userautoload/*.vim
autocmd BufEnter * set mouse=
noremap <leader><TAB> :bnext<CR>
noremap <leader><S-TAB> :bprev<CR>
nnoremap <ESC><ESC> :noh<CR>
