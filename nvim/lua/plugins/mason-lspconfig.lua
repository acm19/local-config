return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- LSP configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        ensure_installed = { "lua_ls", "gopls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "i" }, "<C-K>", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
