return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
				end

				telescope = require("telescope.builtin")

				map("<leader>gd", telescope.lsp_definitions, "[G]oto [D]efinition")
				map("<leader>gr", telescope.lsp_references, "[G]oto [R]eference")
				map("<leader>gi", telescope.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>gt", telescope.lsp_type_definitions, "[G]oto [T]ype Definition")
				map("<leader>gs", telescope.lsp_document_symbols, "[G]oto [D]ocument Symbols")
				map("<leader>gw", telescope.lsp_dynamic_workspace_symbols, "[G]oto [W]orkspace Symbols")
				map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>ct", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[C]ode [T]oggle Hints")
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			lua_ls = {},
			clangd = {},
			pyright = {},
			checkmake = {},
			asm_lsp = {},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"ast-grep",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
