require("vimrc")
require("config.lazy")
require("config.autocmds")

-- Set a lower updatetime for better responsiveness.
-- I making use of CursorHold events. I'll revistit
-- if this causes performance issues.
vim.opt.updatetime = 250

-- Use the system clipboard for all operations.
vim.opt.clipboard = "unnamedplus"
