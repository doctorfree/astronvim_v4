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
  { "stevearc/aerial.nvim", event = "VeryLazy" },
  { "godlygeek/tabular", event = "VeryLazy" },
  {
    "preservim/vim-markdown",
    event = "VeryLazy",
    config = function()
      vim.g.vim_markdown_math = true
      vim.g.vim_markdown_frontmatter = true
      vim.g.vim_markdown_strikethrough = true
      vim.g.vim_markdown_autowrite = true
      vim.g.vim_markdown_toc_autofit = true
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install && git reset --hard",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    event = "VeryLazy",
    config = function()
      require("configs.markdown-preview")
      local wk = require("which-key")
      wk.register({
        m = {
          name = require("icons").ui.Note .. "Markdown",
          p = { ":MarkdownPreview<CR>", "Start Preview" },
          s = { ":MarkdownPreviewStop<CR>", "Stop Preview" },
          t = { ":MarkdownPreviewToggle<CR>", "Toggle Preview" },
        },
      }, {
        prefix = "<Leader>",
        mode = "n",
        { silent = true },
      })
    end,
    ft = { "markdown" },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
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
    end,
  },
}
