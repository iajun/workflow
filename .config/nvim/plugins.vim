" GENERAL

" auto-install plugins upon starting
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Git Integration
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'

" Auto pairs and ssurroundurround for '(' '[' '{' etc.
" Comments
  Plug 'tpope/vim-commentary'

" Multiple Cursors
  Plug 'terryma/vim-multiple-cursors'

" A blazing fast and easy to configure Neovim statusline written in Lua.
  Plug 'hoob3rt/lualine.nvim'

" Lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

" Lsp typescript improvement
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Snippets and completion
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'rafamadriz/friendly-snippets'

" Popup and choosing for completion
  Plug 'nvim-lua/popup.nvim'

" Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-frecency.nvim'
  Plug 'BurntSushi/ripgrep'
  Plug 'tami5/sqlite.lua'
  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'iamcco/diagnostic-languageserver'

" Utils
  Plug 'windwp/nvim-autopairs'
  Plug 'mhartington/formatter.nvim'
  " buffer delete and keeping splitting
  Plug 'moll/vim-bbye'

" Jumper
  Plug 'phaazon/hop.nvim'

" Theme
  Plug 'rafi/awesome-vim-colorschemes'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

