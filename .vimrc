set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin

" theme設定、取りあえず desert
colorscheme desert
set mouse="a"
set nocompatible
"set number "or nonumber
set number
set textwidth=0 "文字の折りたたみ禁止
set nobackup
set autoread
set backspace=indent,eol,start "windows等のBSに近い挙動に
set formatoptions=lmoq
set showcmd
set showmode
set modelines=5
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set wrap
set laststatus=2
set cmdheight=2
set incsearch
set ignorecase
set smartcase
filetype plugin on
filetype indent on
syntax on

call pathogen#infect()

set fileformats=unix,dos,mac

au BufRead,BufNewFile *.tpl set filetype=smarty
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P


