require("formatter").setup(
  {
    logging = true,
    filetype = {
      vim = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      typescriptreact = {
        -- prettier
        function()
          return {
            exe = "prettier-eslint",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--stdin", "true" },
            stdin = true
          }
        end
      },
      typescript = {
        -- prettier
        function()
          return {
            exe = "prettier-eslint",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--stdin", "true" },
            stdin = true
          }
        end
      },
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier-eslint",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--stdin", "true" },
            stdin = true
          }
        end
      },
      vue = {
        -- prettier
        function()
          return {
            exe = "prettier-eslint",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--stdin", "true" },
            stdin = true
          }
        end
      },
      html = {
        -- prettier
        function()
          return {
            exe = "prettier-eslint",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--stdin", "true" },
            stdin = true
          }
        end
      },
      javascriptreact = {
        -- prettier
        function()
          return {
            exe = "prettier-eslint",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--stdin", "true" },
            stdin = true
          }
        end
      },
      json = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      less = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

vim.api.nvim_set_keymap("n", "<leader>f", ":Format<CR>", {silent = true})
