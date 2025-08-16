return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({})
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- LSP configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        ensure_installed = { "lua_ls", "gopls", "golangci_lint_ls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.gopls.setup({
        capabilities = capabilities
      })
      lspconfig.golangci_lint_ls.setup({
        capabilities = capabilities
      })

      -- key bindings
      vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end
  }
}
