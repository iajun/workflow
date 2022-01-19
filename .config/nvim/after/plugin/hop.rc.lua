require "hop".setup()

-- place this in one of your configuration file(s)
vim.api.nvim_set_keymap(
  "n",
  "<space><space>w",
  "<cmd>HopWord<cr>",
  {}
)
