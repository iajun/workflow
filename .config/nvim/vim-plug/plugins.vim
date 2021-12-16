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
"    Plug 'SirVer/ultisnips'

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

" Coc Server
"    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'

" Debugger
    Plug 'puremourning/vimspector'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim51' }
  Plug 'folke/lsp-colors.nvim'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'onsails/lspkind-nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'mhartington/formatter.nvim'
  Plug 'iamcco/diagnostic-languageserver'

call plug#end()

nnoremap <silent> <leader>f :Format<CR>

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.volar.setup{}
EOF
