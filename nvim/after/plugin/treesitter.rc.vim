if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "javascript",
    "typescript",
    "json",
    "python",
    "markdown",
    "vue",
    "vim",
    "tsx",
    "yaml",
    "bash",
    "lua",
    "graphql",
    "html",
    "css",
    "scss",
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
EOF

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
