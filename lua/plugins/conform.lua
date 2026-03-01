return {
  "stevearc/conform.nvim",
  lazy = false,
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        rust = { "rustfmt" },
      },
    })

    -- Explicit format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        conform.format({
          bufnr = args.buf,
          lsp_fallback = false,
          async = false,
        })
      end,
    })
  end,
}
