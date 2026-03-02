return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Completion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",

		-- UI
		"j-hui/fidget.nvim",
	},

	config = function()
		-- ===== Add Mason bin to PATH =====
		vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"

		-- ===== Conform setup =====
		require("conform").setup({
			formatters_by_ft = {},
		})

		-- ===== LuaSnip setup =====
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()

		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
		})

		-- ===== nvim-cmp setup =====
		local cmp = require("cmp")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),

				-- TAB completion + snippet jump
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- ===== Diagnostic config =====
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- ===== Diagnostic keymap (FIXED LOCATION) =====
		vim.keymap.set("n", "<leader>r", vim.diagnostic.open_float, {
			desc = "Show LSP error under cursor",
			silent = true,
			noremap = true,
		})

		-- ===== Fidget =====
		require("fidget").setup({})

		-- ===== Mason =====
		local lspconfig = require("lspconfig")
		require("mason").setup()

		local default_handler = function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end

		local handlers = {
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
						},
					},
				})
			end,
			["tailwindcss"] = function()
				lspconfig.tailwindcss.setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
						"heex",
					},
				})
			end,
		}

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "rust_analyzer", "vtsls", "tailwindcss" },
			handlers = vim.tbl_extend("force", { [1] = default_handler }, handlers),
		})
	end,
}
