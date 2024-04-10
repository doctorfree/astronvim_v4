---@type LazySpec
return {
  { "rakr/vim-one" },
  {
    "sainnhe/sonokai",
    init = function()
      vim.g.sonokai_style = "andromeda"
    end
  },
  { "kvrohit/mellow.nvim" },
  {
    "sainnhe/edge",
    init = function()
      vim.g.edge_style = "neon"
      vim.g.edge_dim_inactive_windows = 1
      vim.g.edge_diagnostic_virtual_text = "colored"
      vim.g.edge_diagnostic_line_highlight = "colored"
    end
  },
  { "projekt0n/github-nvim-theme", lazy = false },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("configs.themes.nightfox")
    end,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    branch = "master",
    priority = 1000,
    keys = { { "<leader>mc", "<cmd>MonokaiProSelect<cr>", desc = "Select Moonokai pro filter" } },
    config = function()
      require("configs.themes.monokai-pro")
    end,
  },
  {
    "sam4llis/nvim-tundra",
    lazy = false,
    priority = 1000,
    config = function()
      require("configs.themes.tundra")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    branch = "main",
    config = function()
      require("configs.themes.tokyonight")
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("configs.themes.dracula")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("configs.themes.kanagawa")
    end,
  },
  {
    "neanias/everforest-nvim",
    name = "everforest",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("configs.themes.everforest")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("configs.themes.catppuccin")
    end,
  },
}
