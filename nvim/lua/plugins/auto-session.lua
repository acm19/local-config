return {
  "rmagatti/auto-session",
  config = function()
    vim.keymap.set("n", "<leader>ls", ":Telescope session-lens<cr>", {})

    require("auto-session").setup({
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/projects", "~/Downloads", "/" },
      purge_after_minutes = 43200, -- 30 days
      session_lens = {
        picker = "telescope",
      },
    })
  end,
}
