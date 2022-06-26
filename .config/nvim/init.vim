source $HOME/.config/nvim/basic.vim
source $HOME/.config/nvim/plug.vim

call plug#begin('~/.vim/plugged')

" styling
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim'

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
" Plug 'puremourning/vimspector'
" tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

"
Plug 'airblade/vim-rooter'

" For yarn PnP
" Plug 'lbrayner/vim-rzip'

"
" lsp
"

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'lukas-reineke/lsp-format.nvim'

call plug#end()


source $HOME/.config/nvim/color.vim
source $HOME/.config/nvim/fzf.vim
source $HOME/.config/nvim/nerdtree.vim
source $HOME/.config/nvim/rooter.vim
luafile $HOME/.config/nvim/lua/treesitter.lua
luafile $HOME/.config/nvim/lua/lsp.lua

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_priority = 11
