return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      -- update mason-lspconfig.lua to ensure the builtins are installed
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier, -- npm install -g prettier
      },
    })

    vim.keymap.set("n", "<A-S-f>", vim.lsp.buf.format, {})
  end,
}
