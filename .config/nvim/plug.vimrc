let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', 'coc-eslint', 'coc-json','coc-git']

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" styling
Plug 'itchyny/lightline.vim'
" ;; toggle files
Plug 'Shougo/unite.vim'
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
" typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" nerdtree
Plug 'scrooloose/nerdtree'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" debugger
Plug 'puremourning/vimspector'

" rust
" Plug 'rust-lang/rust.vim'
" Plug 'cespare/vim-toml'

call plug#end()


"
" Plugin setting
"

" unite
nnoremap <silent> ;; :<C-u>Unite buffer -direction=botright -auto-resize -toggle<CR>

" vim-jsx-typescript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" nerdtree
map <C-a> :NERDTreeToggle %<CR>
nmap <silent> <leader>a <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>A <Plug>(coc-diagnostic-next)
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

" glsl
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

""" coc.nvim

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
nnoremap <C-p> :FZF<Cr>
