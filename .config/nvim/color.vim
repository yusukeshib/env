hi LineNr guifg=#666666
hi CocFloating guibg=#282828 guifg=White
hi link CocUnusedHighlight CocUnderline
hi Pmenu guibg=#282828 guifg=White
hi CursorLine guibg=#666666
hi Visual guifg=reset guibg=#666666 gui=none

" todo color
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
augroup END

hi MyTodo guibg=Red
