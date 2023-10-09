let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Auto brace closing
Plug 'Raimondi/delimitMate'

" Git stylizing +/- stuff in the gutter
Plug 'airblade/vim-gitgutter'

" Keeps your vim root at `pwd`
Plug 'airblade/vim-rooter'

" Batch Snippets provider
Plug 'honza/vim-snippets'

" Interface to ripgrep for inline pretty grepping
Plug 'jremmen/vim-ripgrep'

" coc: main IDE-style features, and provider of extra plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Heuristic tab style detection
Plug 'tpope/vim-sleuth'

" Fzf stuff for fuzzy file searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Good starting theme
Plug 'joshdick/onedark.vim'

" Syntax highlighting provider for many misc languages
Plug 'sheerun/vim-polyglot'

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

call plug#end()

" settings
let mapleader = " "
set fileencoding=UTF-8
set encoding=UTF-8
" save swap every 100ms of no input
set updatetime=100
" Auto syntax from filetype + indents
syntax on
filetype plugin indent on
" indent width
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nostartofline
" tab -> space conversion
set expandtab
" show current line
set number
" show up/down relative line positions
" set relativenumber
" search case insensitive
set ignorecase
" Permanent Undo
set undodir=~/.vimdid
set undofile

set conceallevel=3
" coc helpful settings
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
let g:netrw_liststyle = 3
" set foldmethod
set foldmethod=marker

if !has('gui_running')
  set t_Co=256
endif
" italic comments
hi Comment cterm = italic
" cursor
set guicursor =n-v-c-sm:block,i-ci-ve:hor100-Cursor,r-cr-o:ver100
" highlight current line in insert
autocmd InsertEnter,InsertLeave * set cul!
" show tabline always
set showtabline=2
set regexpengine=0

set mouse=a


" extensions
let g:coc_global_extensions = [
  \  "coc-explorer",
  \  "coc-highlight",
  \  "coc-json",
  \  "coc-lists",
  \  "coc-rust-analyzer",
  \  "coc-snippets"
  \]

colorscheme onedark

nmap <silent> <leader>ct <Plug>(coc-diagnostic-info)

nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cD <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nnoremap          <leader>ca :CocAction<CR>
nmap          <leader>cf <Plug>(coc-fix-current)
nnoremap <silent> <leader>co :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <silent> F :call CocAction('format')<CR>:ALEFix<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

nnoremap <silent> <leader>cl  :<C-u>CocList diagnostics<cr>

nmap <silent> <leader>n :execute "CocCommand explorer" getcwd()<CR>

nnoremap <C-O> :Files<CR>
nnoremap <leader>fb :Buffers<CR>
noremap <leader>fs :Rg<space>

" fix scopes
let delimitMate_expand_cr = 1

" fix broken saving
set fsync

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="bubblegum"