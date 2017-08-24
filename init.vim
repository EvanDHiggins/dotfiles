
" General Config {{{

:set modelines=1

:set shiftwidth=4
:set smarttab
:set expandtab

:let mapleader = "\<space>"

" }}}

" Plugin Loading {{{

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

call plug#end()

" }}}

" NERDTree {{{

" Opens NERDTree when vim is run with no args
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

nnoremap <leader>ft :NERDTreeToggle<CR>

" }}}

" Movement {{{

"Some Nice movement help
:noremap J 10j
:noremap K 10k
:noremap H ^
:noremap L $

" }}}

" Splits {{{

"Maps split switching to my typical leader pattern
:nnoremap <leader>wh <C-W><C-H>
:nnoremap <leader>wj <C-W><C-J>
:nnoremap <leader>wk <C-W><C-k>
:nnoremap <leader>wl <C-W><C-L>
:nnoremap <leader>wt <C-W>T

"Splits open below or to the right of current split.
"Feels much more natural this way
:set splitbelow
:set splitright
" }}}

" Normal Mode {{{

"Taken from "Learn Vimscript the Hard Way" super convenient way of editting
".vimrc
:nnoremap <leader>ve :vsplit $MYVIMRC<CR>
:nnoremap <leader>sv :source $MYVIMRC<CR>

"Faster line deletion
noremap - dd

"Easier Indenting
:noremap <left> <<
:noremap <right> >>

"Easier saving and save-quitting. :q! is not mapped intentionally
:noremap <leader>w :w<CR>
:noremap <leader>wq :wq<CR>
:noremap <leader>q :q<CR>
"}}}

" Insert Mode {{{

"Most important mapping ever, jk quits insert mode. Just mash j and k quicy
:inoremap jk <esc>l
:inoremap kj <esc>l

" }}}

" Visual Mode {{{

"Indents/Unindents selected text
:vnoremap <left> <gv
:vnoremap <right> >gv

" }}}

" Syntax And Coloring {{{

:set termguicolors

:set number
:set cursorline
:syntax enable
:colorscheme gruvbox
:set background=dark

"Highlights column 80
:set colorcolumn=80

" }}}

" vim:foldmethod=marker:foldlevel=0
