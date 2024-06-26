local settings = require("configuration")
local dependencies = { "mfussenegger/nvim-dap" }
if settings.enable_neotest then
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  }
end

---@type LazySpec
return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = dependencies,
  },
  {
    "mfussenegger/nvim-dap",
    config = function() require "configs.dap" end,
    keys = {
      "<Leader>da",
      "<Leader>db",
      "<Leader>dc",
      "<Leader>dd",
      "<Leader>dh",
      "<Leader>di",
      "<Leader>do",
      "<Leader>dO",
      "<Leader>dT",
    },
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
    },
  },
}
