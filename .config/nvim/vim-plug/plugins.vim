" GENERAL

" auto-install plugins upon starting
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Git Integration
    Plug 'mhinz/vim-signify'

" Fuzzy Finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'           " Set up fzf and fzf.vim

" Snippets
    Plug 'SirVer/ultisnips'

" Auto pairs and surround for '(' '[' '{' etc.
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
" Comments
    Plug 'tpope/vim-commentary'

" Multiple Cursors
    Plug 'terryma/vim-multiple-cursors'

" Browser Support
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Satus Line
    Plug 'vim-airline/vim-airline'


call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
