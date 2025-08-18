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

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
    end,
  },
}
