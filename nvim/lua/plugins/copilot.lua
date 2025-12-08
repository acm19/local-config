return {
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    -- default config: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua#L12
    config = function()
      vim.keymap.set("n", "<leader>cc", ":CodeCompanionChat<CR>", { desc = "Code Companion" })
      vim.keymap.set("n", "<leader>ca", ":CodeCompanionActions<CR>", { desc = "Code Companion Action Palette" })

      require("codecompanion").setup({
        ignore_warnings = true, -- ignore warnings until https://github.com/olimorris/codecompanion.nvim/pull/2439 is merged
        display = {
          chat = {
            window = {
              position = "right",
            },
          },
        },
      })
    end,
  },
}
