call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/vim-easy-align'
Plug 'davidhalter/jedi-vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'frazrepo/vim-rainbow'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
" Initialize plugin system
call plug#end()

" Enable Line Numbers
set nu

" Set colorscheme
colorscheme gruvbox

" Nerd Tree Mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Rainbow Brackets
au FileType py call rainbow#load()

