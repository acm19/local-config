return {
  {
    "tpope/vim-fugitive",
    config = function ()
      vim.keymap.set("n", "<C-A>", ":Git add %<CR>", {})
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', {})
    end,
  },
}
