" GENERAL
source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/plugins.vim

" MAPPINGS
source $HOME/.config/nvim/mappings.vim

if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
  " Use NeoSolarized
  let g:neosolarized_termtrans=1
  " runtime ./colors/NeoSolarized.vim
  colorscheme purify
endif
