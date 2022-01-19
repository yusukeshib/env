if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" styling
Plug 'itchyny/lightline.vim'
" Subvert
Plug 'tpope/vim-abolish'
" regex
Plug 'othree/eregex.vim'
" gdiff
Plug 'tpope/vim-fugitive'
" editorconfig
Plug 'editorconfig/editorconfig-vim'
" git diff
Plug 'airblade/vim-gitgutter'
" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" debugger
Plug 'puremourning/vimspector'
" language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'cespare/vim-toml'

"
" Plug 'dracula/vim'

call plug#end()
