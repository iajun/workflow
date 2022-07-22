vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
-- Git Integration
  use {  'mhinz/vim-signify' }
  use {  'tpope/vim-fugitive' }
  use {  'tpope/vim-surround' }

-- Auto pairs and ssurroundurround for '(' '[' '{' etc.
-- Comments
  use {  'tpope/vim-commentary' }

-- Multiple Cursors
  use {  'terryma/vim-multiple-cursors' }

-- A blazing fast and easy to configure Neovim statusline written in Lua.
  use {  'hoob3rt/lualine.nvim' }

-- Lsp
  use {  'neovim/nvim-lspconfig' }
  use {  'williamboman/nvim-lsp-installer' }
  use {  'hrsh7th/cmp-nvim-lsp' }
  use {  'hrsh7th/cmp-buffer' }
  use {  'hrsh7th/cmp-path' }
  use {  'hrsh7th/cmp-cmdline' }
  use {  'uga-rosa/cmp-dictionary' }
  use {  'f3fora/cmp-spell' }
  use {  'David-Kunz/cmp-npm' }
  use {  'hrsh7th/nvim-cmp' }

-- Lsp typescript improvement
  use {  'jose-elias-alvarez/null-ls.nvim' }
  use {  'jose-elias-alvarez/nvim-lsp-ts-utils' }

-- Snippets and completion
  use {  'hrsh7th/cmp-vsnip' }
  use {  'hrsh7th/vim-vsnip' }
  use {  'hrsh7th/vim-vsnip-integ' }
  use {  'rafamadriz/friendly-snippets' }

-- Popup and choosing for completion
  use {  'nvim-lua/popup.nvim' }

-- Telescope
  use {  'nvim-lua/plenary.nvim' }
  use {  'nvim-telescope/telescope.nvim' }
  use {  'nvim-telescope/telescope-ui-select.nvim' }
  use {  'nvim-telescope/telescope-fzf-native.nvim', { run = 'make' } }
  use {  'nvim-telescope/telescope-frecency.nvim' }
  use {  'BurntSushi/ripgrep' }
  use {  'tami5/sqlite.lua' }
  use {  'kyazdani42/nvim-web-devicons' }

  use {  'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
  use {  'iamcco/diagnostic-languageserver' }

-- Utils
  use {  'windwp/nvim-autopairs' }
  use {  'mhartington/formatter.nvim' }
  -- buffer delete and keeping splitting
  use {  'moll/vim-bbye' }

-- Jumper
  use {  'phaazon/hop.nvim' }

-- Theme
  use {  'rafi/awesome-vim-colorschemes' }

-- Formatters
  use {  'andrejlevkovitch/vim-lua-format' }

-- Tree
  use {  'kyazdani42/nvim-tree.lua' }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
