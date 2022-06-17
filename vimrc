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
Plug 'nvie/vim-flake8'
Plug 'vim-airline/vim-airline'
Plug 'Stoozy/vimcord'
Plug 'alfredodeza/pytest.vim'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-endwise'
Plug 'vim-ruby/vim-ruby'
Plug 'farfanoide/vim-kivy'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-gitgutter'
" Initialize plugin system
call plug#end()

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

" Enable Line Numbers
set nu

" Set whitespace tabs
set expandtab
set tabstop=2

" Background
set bg=dark

" Highlighting
set hlsearch
hi Search guibg=LightBlue

" Redraw: <ctrl-l> to redraw
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Set colorscheme
colorscheme gruvbox

" Nerd Tree Mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <leader>tw :StripWhitespace<CR>

nmap ]h <Plug>(GitGutterNextHunk)

" Rainbow Brackets
au FileType py call rainbow#load()
au FileType rb call rainbow#load()

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_setColors = 0

let g:ale_sign_error = '✗'
let g:ale_sign_warning = ' ∆'

" RUBY
let ruby_space_errors = 1

