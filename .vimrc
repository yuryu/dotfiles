set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin

" theme設定、取りあえず desert
colorscheme darkblue 
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

map <C-k><C-k> :Gtags 
map <C-k><C-f> :Gtags -f %<CR>
map <C-i> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" Tabs
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

