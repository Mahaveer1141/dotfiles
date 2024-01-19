set nocompatible
filetype off
syntax on
set tabstop=4
set smartindent
set autoindent
set shiftwidth=4
set belloff=all
set incsearch
set number relativenumber
set expandtab
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}
colorscheme default
highlight PreProc guifg=Purple
autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++17 % -o %:r<CR>
autocmd filetype cpp nnoremap <F10> :!%:r<CR>
autocmd filetype cpp nnoremap <D-/> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
set guifont=FixedsysExcelsiorIIIb:h16
set clipboard=unnamed
set scrolloff=10

