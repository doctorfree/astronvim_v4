-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mason.nvim",
  },
  config = function()
    require("configs.none-ls")
  end,
}
