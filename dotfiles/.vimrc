" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" Install vim-plug if is not
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Initialize plugins with vim-plug 
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'

" Plug 'plasticboy/vim-markdown'

Plug 'chrisbra/vim-commentary'

" Side marks to indicate Git changes
Plug 'mhinz/vim-signify'

" Themes (colorschemes)
Plug 'drewtempelmeyer/palenight.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'nlknguyen/papercolor-theme'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" Highlighting search pattern.
set hlsearch

" Coloring
syntax on
set background=dark
colorscheme palenight

" Italics for Palenight
let g:palenight_terminal_italics=1

" Lightline for Palenight
" let g:lightline.colorscheme = 'palenight'

" Lightline
set laststatus=2

" Visual wrapping
set wrap
set linebreak
set nolist  " list disables linebreak

" Enable mouse integration
set mouse=a

" Disable backups
set nobackup
set nowritebackup
set noswapfile

" Disable folding (for markdown basically)
set nofoldenable 

" Autosave files on focus lost
au FocusLost * :wa

" Enable line numbers
set number
" autocmd FileType markdown set nonumber | " disable line numbers for markdown

" Highlight current line
set cursorline

" Comment string
autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
filetype on | " should go after autocmds to avoid overwritting them

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key remmaping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use `sed -n l` in your shell to identify Alt key mapping
" ^[[1;9D  ---> <Esc>[1;9D
"
" Reduce timeout
"set timeoutlen=1
set notimeout
set ttimeoutlen=1

" Move lines up/down
nnoremap <Esc>j :m .+1<CR>==
nnoremap <Esc>k :m .-2<CR>==
nnoremap <Esc>[1;3B :m .+1<CR>==
nnoremap <Esc>[1;3A :m .-2<CR>==

"inoremap <Esc>j :m .+1<CR>==       " TODO: don't know how to
"inoremap <Esc>k :m .-2<CR>==       " - map to simultaneous key-press 
"inoremap <Esc>[1;3B :m .+1<CR>==   " - distinguis ALT and ESC keys
"inoremap <Esc>[1;3A :m .-2<CR>==   " - or set negligible timeout

" Copy lines up/down
nnoremap <Esc>J VyP
nnoremap <Esc>K Vyp
nnoremap <Esc>[1;4A VyP
nnoremap <Esc>[1;4B Vyp

inoremap <Esc>J <c-o>Vy<c-o>P
inoremap <Esc>[1;4A <c-o>Vy<c-o>P
inoremap <Esc>K <c-o>Vy<c-o>p
inoremap <Esc>[1;4B <c-o>Vy<c-o>p

" Exit INSERT mode
inoremap jj <Esc>
