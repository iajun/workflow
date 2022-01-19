local nvim_lsp = require "lspconfig"
local util = require "lspconfig.util"
local global_tsserverlib = string.gsub(os.getenv("NVM_BIN"), "/bin", "") .. "/lib/node_modules/typescript/lib"

local function get_typescript_server_path(root_dir)
  local project_root = util.find_node_modules_ancestor(root_dir)

  local local_tsserverlib =
    project_root ~= nil and util.path.join(project_root, "node_modules", "typescript", "lib", "tsserverlibrary.js")

  if local_tsserverlib and util.path.exists(local_tsserverlib) then
    return local_tsserverlib
  else
    return global_tsserverlib .. "/tsserverlibrary.js"
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {noremap = true, silent = true}

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
end

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"typescript-language-server", "--stdio", "--tsserver-path=" .. global_tsserverlib}
}
nvim_lsp.vimls.setup {}
nvim_lsp.cssls.setup {}
nvim_lsp.volar.setup {
  filetypes = {"typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json"},
  on_attach = on_attach,
  init_options = {
    typescript = {
      serverPath = global_tsserverlib..'/tsserverlibrary.js'
    }
  }
}

nvim_lsp.diagnosticls.setup {
  filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css", "vue"},
  init_options = {
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      javascriptreact = "eslint",
      typescriptreact = "eslint"
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = {
          ".eslintrc.js",
          ".eslintrc",
          ".eslintrc.json",
          "package.json"
        },
        debounce = 100,
        args = {
          "--cache",
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    }
  }
}

--Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require "cmp"
cmp.setup(
  {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end
    },
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping(
        {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close()
        }
      ),
      ["<C-y>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "vsnip"} -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      },
      {
        {name = "buffer"}
      }
    )
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    sources = {
      {name = "buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        {name = "path"}
      },
      {
        {name = "cmdline"}
      }
    )
  }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
