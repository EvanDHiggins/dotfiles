"********************
"
"   General Config
"
"********************

:nnoremap <leader>a <C-a>

"Sets general config files
:set shiftwidth=4
:set smarttab
:set expandtab

"Sets leader to spacebar
:let mapleader = "\<space>"

:set backspace=2

"*******************
"
"       Vundle
"
"********************
"Vundle complains about fish shell, this changes commands to bash
:set shell=/bin/bash
"This is all just required for Vundle
:set nocompatible
:filetype off
:set rtp+=~/.vim/bundle/Vundle.vim
:call vundle#begin()
"Plugins should go here

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

:call vundle#end()
:filetype plugin indent on
"********************
"
"      Plugins
"
"********************

:noremap <leader>t :NERDTreeToggle<CR>
:let NERDTreeIgnore = ['\.pyc$', '\.hi$', '\.o$']
:noremap <leader>n :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Forces Airline to run all the time
:set laststatus=2
"Turns off standard mode indicator. Replaced by Airline
:set noshowmode

"Sets snippet directory to something outside of /bundle
:let g:UltiSnipsSnippetDirectories=["UltiSnips"]

:let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

"" YouCompleteMe
:let g:ycm_key_list_previous_completion=['<Up>']
:let g:clang_user_options="-std=c++0x"
:let g:ycm_register_as_syntastic_checker="true"

"" Ultisnips
:noremap <leader>u :vsplit<CR>:UltiSnipsEdit<CR>

"This is the voodoo required to make utlisnips work well enough with
"YouCompleteMe.  Ctrl-Space is the trigger now, not the greatest, but it works
:let g:UltiSnipsExpandTrigger = '<C-@>'   " terminals send C-@ when C-Space is pressed.
:let g:UltiSnipsJumpForwardTrigger = '<C-%>' " some key I do not use at all

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        call UltiSnips#JumpForwards()
        if g:ulti_jump_forwards_res == 0
            return ""  " nothing more to do
        endif
    endif
    return ""
endfunction

:au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

:let g:ctrlp_extensions = ['tag']

:set tags+=tags

:let g:UltiSnipsExpandTrigger = '<c-space>'

""""
"Syntastic
""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
autocmd VimEnter * SyntasticToggleMode "Default to passive mode

:nnoremap <leader>sc :SyntasticCheck<CR>
:nnoremap <leader>sr :SyntasticReset<CR>
"********************
"
"Syntax And Coloring
"
"********************

"Sets background dark. Very important that this is first for some strange
"reason
"set background=dark

"Enables syntax coloring
:syntax enable
:set number
:colorscheme jellybeans
:set cursorline

"Used to enable 256 colors
:set t_Co=256

"Sets working directory to that of the file open in the buffer
:set autochdir

"Highlights column 80
:set colorcolumn=80

"" YouCompleteMe
:let g:ycm_key_list_previous_completion=['<Up>']


"********************
"
"     Vim Splits 
"
"********************

"Splits open below or to the right of current split.
"Feels much more natural this way
:set splitbelow
:set splitright

"Maps split switching to my typical leader pattern
:nnoremap <leader>sh <C-W><C-H>
:nnoremap <leader>sj <C-W><C-J>
:nnoremap <leader>sk <C-W><C-k>
:nnoremap <leader>sl <C-W><C-L>

"********************
"
"    Normal Mode
"
"********************

"Navigate Buffers faster
:nnoremap <leader>nb :bn<CR>
:nnoremap <leader>pb :bp<CR>
:nnoremap <leader>db :b#<bar>bd#<CR>

:nnoremap <leader>nt :tabn<CR>
:nnoremap <leader>pt :tabp<CR>
:nnoremap <leader>ts :tab split<CR>
:nnoremap <leader>tc :tab close<CR>

"Some Nice movement help
:noremap J 10j
:noremap K 10k
:noremap H ^
:noremap L $

"Faster line deletion
noremap - dd

"Arrow keys shift lines up and down
:noremap <up> ddkkp
:noremap <down> ddp

:noremap <left> <<
:noremap <right> >>

"Add some extra lines when using o command
:noremap <leader>O o<CR><C-o>O
:noremap <leader>o o<C-o>O

"Easier saving and save-quitting. :q! is not mapped intentionally
:noremap <leader>w :w<CR>
:noremap <leader>wq :wq<CR>
:noremap <leader>q :q<CR>

"Taken from "Learn Vimscript the Hard Way" super convenient way of editting
".vimrc
:nnoremap <leader>ve :vsplit $MYVIMRC<CR>
:nnoremap <leader>sv :source $MYVIMRC<CR>

"Add semicolon to end of line
:nnoremap <leader>; $a;<Esc>

" Removes trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
"********************
"
"    Insert Mode
"
"********************

"Most important mapping ever, jk quits insert mode. Just mash j and k quicy
:inoremap jk <esc>l
:inoremap kj <esc>l

"allows movement through autocompletion lists
:inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
:inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

"Better curly brace functionality, probably a plugin to do this better
:inoremap {      {}<Left>
:inoremap {<CR>  {<CR>}<Esc>O
:inoremap {{     {
:inoremap {}     {}

"********************
"
"    Visual Mode
"
"********************

"Indents/Unindents selected text
:vnoremap <left> <gv
:vnoremap <right> >gv
