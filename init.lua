-- You will need to install language servers `npm i -g vscode-langservers-extracted` and `npm install -g typescript typescript-language-server`

local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables

-- Map leader to space
g.mapleader = ","

-- Bootstrap Paq when needed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", install_path })
end

-- Plugins
require("paq")({
  "f3fora/cmp-spell",
  "EdenEast/nightfox.nvim",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/nvim-cmp",
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "jose-elias-alvarez/null-ls.nvim",
  "kyazdani42/nvim-tree.lua",
  "kyazdani42/nvim-web-devicons",
  "lewis6991/gitsigns.nvim",
  "nathom/filetype.nvim",
  "neovim/nvim-lspconfig",
  "norcalli/nvim-colorizer.lua",
  "numToStr/Comment.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lualine/lualine.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",
  "nvim-telescope/telescope.nvim",
  "luukvbaal/stabilize.nvim",
  "nvim-treesitter/nvim-treesitter",
  "octaltree/cmp-look",
  "simrat39/symbols-outline.nvim",
  "onsails/lspkind-nvim",
  "p00f/nvim-ts-rainbow",
  "goolord/alpha-nvim",
  "phaazon/hop.nvim",
  "savq/paq-nvim",
  "Shatur/neovim-session-manager",
  "filipdutescu/renamer.nvim",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "wellle/targets.vim",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "winston0410/cmd-parser.nvim",
  "winston0410/range-highlight.nvim",
})

-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

require("nvim-tree").setup()
require("renamer").setup()
require("stabilize").setup()
require("Comment").setup()
require("session_manager").setup({
  autoload_mode = "Disabled",
})
require("nvim-autopairs").setup({})
require("range-highlight").setup({})

-- Symbols config
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  width = 50,
  position = "right",
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = {
    close = "<Esc>",
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = { "null-ls" },
}

-- Dashboard
local dashboard = require("alpha.themes.dashboard")
math.randomseed(os.time())

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = "Function"
  b.opts.hl_shortcut = "Type"
  return b
end

local function pick_color()
  local colors = { "String", "Identifier", "Keyword", "Number" }
  return colors[math.random(#colors)]
end

local function footer()
  -- local total_plugins = #vim.tbl_keys(packer_plugins)
  local datetime = os.date("%d-%m-%Y  %H:%M:%S")
  return datetime
end

dashboard.section.header.val = {

  [[__/\\\\\\\\\\\\\____/\\\\\\\\\\\\\\\_       ]],
  [[ _\/\\\/////////\\\_\/\\\///////////__      ]],
  [[  _\/\\\_______\/\\\_\/\\\_____________     ]],
  [[   _\/\\\\\\\\\\\\\\__\/\\\\\\\\\\\_____    ]],
  [[    _\/\\\/////////\\\_\/\\\///////______   ]],
  [[     _\/\\\_______\/\\\_\/\\\_____________  ]],
  [[      _\/\\\_______\/\\\_\/\\\_____________ ]],
  [[       _\/\\\\\\\\\\\\\/__\/\\\_____________]],
  [[        _\/////////////____\///_____________]],
}
dashboard.section.header.opts.hl = pick_color()

dashboard.section.buttons.val = {
  button("<Leader>f", "  File Explorer"),
  button("<Leader>p", "  Find file"),
  button("<Leader>g", "  Find word"),
  button("<Leader>1", "  Open session"),
  button("<Leader>n", "  New file"),
  button("<Leader>v", "  Config"),
  button("<Leader>u", "  Update plugins"),
  button("q", "  Quit", "<Cmd>qa<CR>"),
}

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

require("alpha").setup(dashboard.opts)

require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "markdown",
    },
  },
})

-- gitsigns setup
require("gitsigns").setup({
  numhl = true,
  signcolumn = false,
})

-- LSP this is needed for LSP completions in CSS along with the snippets plugin
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- Different machine VAR for office
local envMachine = os.getenv("MACHINE")
if envMachine == "work" then
  machineCmd =
    "/System/Volumes/Data/usr/local/lib/node_modules/vscode-langservers-extracted/bin/vscode-css-language-server"
else
  machineCmd = "vscode-css-language-server"
end

-- LSP Server config
require("lspconfig").cssls.setup({
  cmd = { machineCmd, "--stdio" },
  settings = {
    scss = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
})
require("lspconfig").tsserver.setup({
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
})

-- LSP Prevents inline buffer annotations
vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
})

local signs = {
  Error = "ﰸ",
  Warn = "",
  Hint = "",
  Info = "",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
end

-- Setup treesitter
local ts = require("nvim-treesitter.configs")
ts.setup({ ensure_installed = "maintained", highlight = { enable = true } })

-- cmd([[colorscheme everforest]]) -- Put your favorite colorscheme here

-- Nightfox config
local nightfox = require("nightfox")
nightfox.setup({
  fox = "nordfox",
  alt_nc = true,
  visual = true,
  search = true,
  styles = {
    comments = "italic",
    keywords = "bold",
    functions = "italic,bold",
  },
})
nightfox.load()

-- Good info on overriding colors: https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
-- Note had to add the SpecialKey to keep highlight on yank working alongside the CursorLine override
vim.api.nvim_exec(
  [[
function! MyHighlights() abort
    highlight CursorLine guifg=NONE guibg=#353A54
    highlight CmpItemAbbr guifg=#9FA4B6
    highlight SpecialKey guibg=NONE
    highlight CmpItemKind guifg=#8289A0
    highlight CmpItemMenu guifg=#8289A0
    highlight PmenuSel guibg=#73daca guifg=#111111
    highlight Pmenu guibg=#2E3248
    highlight GitSignsAddNr guifg=#26A07A
    highlight GitSignsDeleteNr guifg=#E87D7D
    highlight GitSignsChangeNr guifg=#AD991F
    endfunction
augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END]],
  true
)
-- cmd([[colorscheme nightfox]]) -- Put your favorite colorscheme here

require("options")
-- This little monkey has to go after termguicolors is set or gets upset
require("colorizer").setup()

-- Use spelling for markdown files ‘]s’ to find next, ‘[s’ for previous, 'z=‘ for suggestions when on one.
-- Source: http:--thejakeharding.com/tutorial/2012/06/13/using-spell-check-in-vim.html
-- Also I'm adding different sources for completion here, if you aren't on Mac you might need to install "look"
vim.api.nvim_exec(
  [[
augroup markdownSpell
    autocmd!
    autocmd FileType markdown,md,txt setlocal spell
    autocmd BufRead,BufNewFile *.md,*.txt,*.markdown setlocal spell
autocmd FileType markdown,md,txt lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'spell' },
\     { name = 'buffer' },
\     { name = 'look', keyword_length=3 },
\   },
\ }
augroup END
]],
  false
)

local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    return tostring(vim.fn.wordcount().words) .. " words"
  else
    return ""
  end
end

-- local lineNum = vim.api.nvim_win_get_cursor(0)[1]
local function getLines()
  return tostring(vim.api.nvim_win_get_cursor(0)[1]) .. "/" .. tostring(vim.api.nvim_buf_line_count(0))
end

local function getColumn()
  local val = vim.api.nvim_win_get_cursor(0)[2]
  -- pad value to 3 units to stop geometry shift
  return string.format("%03d", val)
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function blank()
  return tostring(" ")
end
-- get colors from Nightfox to use in the words count
local nfColors = require("nightfox.colors").init("nordfox")

-- print(vim.inspect(nfColors))
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "nightfox",
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", source = diff_source, color_added = "#a7c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_lsp" } },
      function()
        return "%="
      end,
      "filename",
      {
        getWords,
        color = { fg = nfColors["bg_alt"] or "#333333", bg = nfColors["fg"] or "#eeeeee" },
        separator = { left = "", right = "" },
      },
    },
    lualine_x = { "filetype" },
    lualine_y = {
      { blank, padding = 0 },
    },
    lualine_z = {
      { getColumn, padding = { left = 1, right = 0 } },
      { getLines, icon = "", padding = 1 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
  },
})

-- Give me some fenced codeblock goodness
g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }

-- Telescope Global remapping
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    winblend = 20,
    sorting_strategy = "descending",
    layout_strategy = "flex",
    layout_config = {
      flex = {
        flip_columns = 140,
      },
      vertical = {
        preview_cutoff = 40,
        prompt_position = "bottom",
      },
      horizontal = {
        width = 0.9,
        height = 0.8,
      },
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<C-w>"] = "delete_buffer",
        },
        n = {
          ["<C-w>"] = "delete_buffer",
        },
      },
    },
    -- https://gitter.im/nvim-telescope/community?at=6113b874025d436054c468e6 Fabian David Schmidt
    find_files = {
      on_input_filter_cb = function(prompt)
        local find_colon = string.find(prompt, ":")
        if find_colon then
          local ret = string.sub(prompt, 1, find_colon - 1)
          vim.schedule(function()
            local prompt_bufnr = vim.api.nvim_get_current_buf()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local lnum = tonumber(prompt:sub(find_colon + 1))
            if type(lnum) == "number" then
              local win = picker.previewer.state.winid
              local bufnr = picker.previewer.state.bufnr
              local line_count = vim.api.nvim_buf_line_count(bufnr)
              vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(lnum, line_count)), 0 })
            end
          end)
          return { prompt = ret }
        end
      end,
      attach_mappings = function()
        actions.select_default:enhance({
          post = function()
            -- if we found something, go to line
            local prompt = action_state.get_current_line()
            local find_colon = string.find(prompt, ":")
            if find_colon then
              local lnum = tonumber(prompt:sub(find_colon + 1))
              vim.api.nvim_win_set_cursor(0, { lnum, 0 })
            end
          end,
        })
        return true
      end,
    },
  },
})

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("sessions")
-------------------- COMMANDS ------------------------------
cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}") -- disabled in visual mode

local lspkind = require("lspkind")
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "buffer" },
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {
        buffer = "",
        nvim_lsp = "",
        spell = "",
        look = "",
      },
    }),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
-- Setup lspconfig.
-- Here is the formatting config
local null_ls = require("null-ls")
local lSsources = {
  null_ls.builtins.formatting.prettier.with({
    filetypes = {
      "javascript",
      "typescript",
      "css",
      "scss",
      "html",
      "json",
      "yaml",
      "markdown",
      "graphql",
      "md",
      "txt",
    },
  }),
  null_ls.builtins.formatting.stylua.with({
    args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
  }),
}
require("null-ls").config({
  sources = lSsources,
})
require("lspconfig")["null-ls"].setup({})
-- the duration in there is to stop timeouts on massive files
vim.cmd("autocmd BufWritePost * lua vim.lsp.buf.formatting_seq_sync(nil, 7500)")
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])
require("mappings")
