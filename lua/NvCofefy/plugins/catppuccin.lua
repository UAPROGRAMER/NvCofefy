return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			term_colors = true,
			styles = {
				conditionals = {},
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mason = true,
				which_key = true,
				illuminate = {
					enabled = true,
					lsp = true,
				},
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				indent_blankline = {
					enabled = true,
					scope_color = "blue",
					colored_indent_levels = false,
				},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
