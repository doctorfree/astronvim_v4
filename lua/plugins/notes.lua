local settings = require("configuration")
local obsidian_vault = settings.obsidian_vault

---@type LazySpec
return {
  {
    "toppair/peek.nvim",
    event = { "BufRead", "BufNewFile" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  --Markdown (or any Outline)
  { "simrat39/symbols-outline.nvim", event = "VeryLazy" },
  { "stevearc/aerial.nvim",          event = "VeryLazy" },
  { "godlygeek/tabular",             event = "VeryLazy" },
  {
    "preservim/vim-markdown",
    event = "VeryLazy",
    config = function()
      vim.g.vim_markdown_math = true
      vim.g.vim_markdown_frontmatter = true
      vim.g.vim_markdown_strikethrough = true
      vim.g.vim_markdown_autowrite = true
      vim.g.vim_markdown_toc_autofit = true
    end
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    event = { "BufReadPre " .. vim.fn.expand "~" .. "/" .. obsidian_vault .. "/**.md" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "preservim/vim-markdown",
    },
    config = function()
      require("configs.obsidian")
    end
  },
}
