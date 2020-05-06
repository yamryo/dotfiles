"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "html,perl,python,ruby"
let g:vim_bootstrap_editor = "vim"				" nvim or vim

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'itchyny/lightline.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

"" To be confirmed
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
"Plug 'vim-scripts/grep.vim'
"Plug 'vim-scripts/CSApprox'
"Plug 'bronson/vim-trailing-whitespace'
"Plug 'Raimondi/delimitMate'
"Plug 'majutsushi/tagbar'
"Plug 'scrooloose/syntastic'
"Plug 'Yggdroot/indentLine'
"Plug 'avelino/vim-bootstrap-updater'
"Plug 'sheerun/vim-polyglot'

"if isdirectory('/usr/local/opt/fzf')
"  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
"else
"  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"  Plug 'junegunn/fzf.vim'
"endif
"let g:make = 'gmake'
"if exists('make')
"        let g:make = 'make'
"endif

"Plug 'Shougo/vimproc.vim', {'do': g:make}

"Plug 'Shougo/vimshell.vim'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"" Vim-Session
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************
"" python
Plug 'davidhalter/jedi-vim'

"" ruby
"Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'

"" html
"Plug 'hail2u/vim-css3-syntax'
"Plug 'gorodinskiy/vim-coloresque'
"Plug 'tpope/vim-haml'
"Plug 'mattn/emmet-vim'
"
"" perl
"Plug 'vim-perl/vim-perl'
"Plug 'c9s/perlomni.vim'
"
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on
