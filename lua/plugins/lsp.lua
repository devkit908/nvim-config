return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- New API (Neovim 0.11+)
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })

    vim.lsp.config("solargraph", {
      capabilities = capabilities,
    })

    vim.lsp.config("html", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
    })

    -- Enable the servers
    vim.lsp.enable({
      "ts_ls",
      "rust-analyzer",
      "solargraph",
      "html",
      "lua_ls",
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>r", vim.diagnostic.open_float, {
      desc = "Show LSP error under cursor",
      silent = true,
      noremap = true,
    })
    vim.keymap.set("n", "K", vim.lsp.buf.hover)
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
  end,
}
