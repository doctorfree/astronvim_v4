local settings = require("configuration")
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = settings.treesitter_ensure_installed
  end,
}
