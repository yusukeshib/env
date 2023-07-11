if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" styling
Plug 'itchyny/lightline.vim'

" file rename
Plug 'qpkorr/vim-renamer'

" subvert
Plug 'tpope/vim-abolish'

" regex
Plug 'othree/eregex.vim'

" git diff
Plug 'tpope/vim-fugitive'
" git diff indicator
Plug 'airblade/vim-gitgutter'

" editor config
Plug 'editorconfig/editorconfig-vim'

" shader
Plug 'tikhomirov/vim-glsl'

" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" rooter
Plug 'airblade/vim-rooter'

" spell check
Plug 'kamykn/spelunker.vim'
Plug 'kamykn/popup-menu.nvim'

" Copilot
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'

"
" lsp
"

Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
Plug 'folke/trouble.nvim'

Plug 'simrat39/rust-tools.nvim'
Plug 'weilbith/nvim-code-action-menu'

call plug#end()

