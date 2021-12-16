" GENERAL
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/vim-plug/plugins.vim

" MAPPINGS
source $HOME/.config/nvim/keys/mappings.vim

" AUTOCOMPLETE
" source $HOME/.config/nvim/plug-config/coc.vim

if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
  " Use NeoSolarized
  let g:neosolarized_termtrans=1
  runtime ./colors/NeoSolarized.vim
  colorscheme NeoSolarized
endif
