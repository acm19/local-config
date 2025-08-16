return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      -- update mason-lspconfig.lua to ensure the builtins are installed
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })

    vim.keymap.set("n", "<A-S-f>", vim.lsp.buf.format, {})
  end,
}
