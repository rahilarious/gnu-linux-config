" show line numbers relatively
set number relativenumber
if has('mouse')
  set mouse=a
endif
" conceallevel - show bars on tags and stars on tags targets 
set conceallevel=0
highlight link HelpBar Normal
highlight link HelpStar Normal
" incremental search and highlight search
set incsearch
set hlsearch
" cursor always in the middle
set scrolloff=99
" enables undo even after you close vim
" set undofile
