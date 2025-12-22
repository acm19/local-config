vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.cmd("set fileformat=unix")
vim.cmd("set fileformats=unix,dos")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set number")
vim.cmd("set relativenumber")

-- Keybindings sections --

-- Move line up with Alt+Shift+K or Alt+Shift+Up
vim.keymap.set("n", "<A-S-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-S-Up>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move line down with Alt+Shift+J or Alt+Shift+Down
vim.keymap.set("n", "<A-S-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-S-Down>", ":m .+1<CR>==", { desc = "Move line down" })

-- Exit insert mode with 'jj' or 'jk'
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, desc = "Exit insert mode" })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, desc = "Exit insert mode" })

-- Close current buffer with <leader>bd
vim.keymap.set("n", "<C-A-D>", ":bp | bd #<CR>", { silent = true })
