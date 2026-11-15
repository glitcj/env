" glitcj base vimrc. Source of truth lives in the env repo; push with `just push-vimrc`.
set nocompatible
filetype plugin indent on
syntax on

" Display
set number
set ruler
set showcmd
set showmatch
set scrolloff=5
set wildmenu
set mouse=a
set encoding=utf-8

" Bottom bar: file, modified/readonly flags, filetype, line:col, percent
set laststatus=2
set statusline=\ %f\ %m%r%h%w%=%y\ \ %l:%c\ \ %p%%\

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Editing
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set backspace=indent,eol,start
set hidden
