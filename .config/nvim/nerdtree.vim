" nerdtree
map <C-a> :NERDTreeToggle %<CR>
nmap <silent> <leader>a <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>A <Plug>(coc-diagnostic-next)
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1

" https://github.com/preservim/nerdtree/issues/1321
let g:NERDTreeMinimalMenu=1
