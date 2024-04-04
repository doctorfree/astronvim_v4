if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

- Not yet working
local settings = require "configuration"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts) opts.ensure_installed = settings.treesitter_ensure_installed end,
}
