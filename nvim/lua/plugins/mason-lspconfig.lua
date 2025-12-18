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
      -- Highlighting the symbol under the cursor
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = args.buf, group = group })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = args.buf,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = args.buf,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "i" }, "<C-K>", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
