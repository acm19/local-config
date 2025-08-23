return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go"
  },
  config = function()
    require("dap-go").setup()
    require("dapui").setup()
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    vim.keymap.set("n", "<F5>", function() dap.continue() end)
    vim.keymap.set("n", "<F10>", function() dap.step_over() end)
    vim.keymap.set("n", "<F11>", function() dap.step_into() end)
    vim.keymap.set("n", "<F12>", function() dap.step_out() end)
    vim.keymap.set("n", "<S-F5>", function()
      dap.terminate()
      dapui.close()
    end)
    vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end)
    vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint() end)
    vim.keymap.set("n", "<Leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
    vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end)
    vim.keymap.set("n", "<Leader>dl", function() dap.run_last() end)

    -- try to load project-specific config
    local ok, project_dap = pcall(dofile, vim.fn.getcwd() .. "/.nvim/dap.lua")
    if ok and type(project_dap) == "table" then
      dap.configurations.go = project_dap
    end
  end,
}
