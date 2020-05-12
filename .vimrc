" ~/.vimrc
"*********************************************************************
"" Basic Setup
"*********************************************************************
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set bomb
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set showcmd

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

set clipboard+=unnamed
set wildmenu

"" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1


"" To be confirmed
"set binary
"" Map leader to ,
"let mapleader=','

"*********************************************************************
"" Visual Settings
"*********************************************************************
syntax on
set ruler
set number
set nowrap

set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F


"" To be confirmed
"let no_buffers_menu=1
"set mousemodel=popup
"set t_Co=256
"set gfn=Monospace\ 10
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
"nnoremap n nzzzv
"nnoremap N Nzzzv


"" Deactivate
"set guioptions=egmrti
"if has("gui_running")
"  if has("gui_mac") || has("gui_macvim")
"    set guifont=Menlo:h12
"    set transparency=7
"  endif
"else
"  let g:CSApprox_loaded = 1
"  " IndentLine
"  let g:indentLine_enabled = 1
"  let g:indentLine_concealcursor = 0
"  let g:indentLine_char = '┆'
"  let g:indentLine_faster = 1
"  if $COLORTERM == 'gnome-terminal'
"    set term=gnome-256color
"  else
"    if $TERM == 'xterm'
"      set term=xterm-256color
"    endif
"  endif
"endif


"*********************************************************************
"" Abbreviations
"*********************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


"*********************************************************************
"" Plugins 
"*********************************************************************
runtime! autoload/my-plugins.vim
runtime! autoload/plugin-configs/*.vim


"***************
"" End of File
"***************
