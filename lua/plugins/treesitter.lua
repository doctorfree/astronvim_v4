return {
  "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
    },
    config = function()
      require("configs.treesitter")
    end,
}
