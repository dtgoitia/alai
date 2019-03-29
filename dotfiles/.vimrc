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

" Install Palenight theme
Plug 'drewtempelmeyer/palenight.vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()


" Highlighting search pattern.
set hlsearch

" Coloring
colorscheme default
syntax on
set background=dark
" colorscheme solarized
colorscheme palenight

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

" Autosave files on focus lost
" au FocusLost * :wa

" Enable line numbers
set number
autocmd FileType markdown set nonumber