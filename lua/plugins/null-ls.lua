return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "mason.nvim",
  },
  config = function()
    require("configs.null-ls")
  end,
}
