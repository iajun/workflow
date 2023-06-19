local opts_override = {
  relativenumber = true,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()"
}

for k, v in pairs(opts_override) do
  vim.opt[k] = v
end


local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"

formatters.setup {
  {
    name = "prettierd",
    filetypes = { "typescript", "typescriptreact", "vue", "json", "javascript", "javascriptreact", "yaml", "css", "less",
      "scss", "html", "graphql" },
  },
}

linters.setup {
  {
    name = "eslint_d",
    filter = function(diagnostic)
      return diagnostic.code ~= "prettier/prettier"
    end
  },
}

lvim.plugins = {
  {
    "tpope/vim-surround",
    "mg979/vim-visual-multi",
    "arcticicestudio/nord-vim",
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("hop").setup()
        vim.api.nvim_set_keymap("n", "<leader>s", ":HopChar2<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "<leader>S", ":HopWord<cr>", { silent = true })
      end,
    },
    {
      "zbirenbaum/copilot.lua",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end,
    },
    {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua" },
      config = function()
        require("copilot_cmp").setup()
      end
    }
  }
}

