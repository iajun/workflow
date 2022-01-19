-- function telescope_buffer_dir()
--   return vim.fn.expand('%:p:h')
-- end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    mappings = {},
    preview = {
      treesitter = false
    },
  },
  pickers = {
    git_files = {
      show_untracked = true
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
telescope.load_extension('fzf')

vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>lua require('telescope.builtin').git_files()<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<C-g>', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', "<cmd>lua require('telescope.builtin').file_browser()<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', "<cmd>Telescope buffers<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', "<cmd>Telescope help_tags<cr>", { silent = true })
