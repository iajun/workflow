-- function telescope_buffer_dir()
--   return vim.fn.expand('%:p:h')
-- end

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		winblend = 40,
		layout_strategy = "horizontal",
		path_display = {
			smart = true,
			shorten = 2,
		},
		border = false,
		layout_config = {
			height = 0.95,
			preview_width = 0.7,
		},
		mappings = {},
		preview = {
			treesitter = true,
		},
	},
	pickers = {
		git_files = {
			show_untracked = true,
		},
		buffers = {
			ignore_current_buffer = true,
			sort_lastused = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
	},
})

require("telescope").load_extension("ui-select")

vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>to",
	"<cmd>lua require('telescope.builtin').file_browser()<cr>",
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>td",
	"<cmd>lua require('telescope.builtin').git_bcommits()<cr>",
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>tb",
	"<cmd>lua require('telescope.builtin').git_branches()<cr>",
	{ silent = true }
)
-- builtin.lsp_type_definitions
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", {
	silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua require('telescope.builtin').git_status()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>tr", "<cmd>lua require('telescope.builtin').resume()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>te", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').fd()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua require('telescope.builtin').treesitter()<cr>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>tw",
	"<cmd>lua require('telescope.builtin').buffers({ show_all_buffers = true })<cr>",
	{ silent = true }
)
