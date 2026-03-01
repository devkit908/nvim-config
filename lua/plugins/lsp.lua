return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        -- ===== Add Mason bin to PATH =====
        vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"

        -- ===== Conform setup (formatters placeholder) =====
        require("conform").setup({
            formatters_by_ft = {
                -- e.g., lua = { "stylua" }
            }
        })

        -- ===== nvim-cmp setup =====
        local cmp = require('cmp')
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            -- ===== Keybinding to show diagnostics under cursor =====
            vim.keymap.set('n', '<leader>r', vim.diagnostic.open_float, {
                desc = "Show LSP error under cursor",
                silent = true,
                noremap = true,
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        -- ===== Diagnostic float config =====
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

        -- ===== Fidget for LSP progress =====
        require("fidget").setup({})

        -- ===== Mason setup =====
        local lspconfig = require("lspconfig")
        require("mason").setup()

        -- Default handler for all LSPs not explicitly configured
        local default_handler = function(server_name)
            lspconfig[server_name].setup({ capabilities = capabilities })
        end


        -- Explicit handlers for specific LSPs
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
                            format = {
                                enable = true,
                                defaultConfig = { indent_style = "space", indent_size = "2" },
                            },
                        }
                    }
                })
            end,
            ["tailwindcss"] = function()
                lspconfig.tailwindcss.setup({
                    capabilities = capabilities,
                    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "heex" },
                })
            end,
        }

        -- ===== Mason-LSPConfig setup (v2 compatible) =====
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "vtsls", "tailwindcss" },
            auto_install = true,
            handlers = vim.tbl_extend("force", { [1] = default_handler }, handlers or {}),
        })
    end
}
