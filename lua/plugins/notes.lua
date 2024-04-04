local settings = require("configuration")
local notes = settings.neorg_notes
if notes == "" or notes == nil then
  notes = { "~/notes" }
end

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
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    build = ":Neorg sync-parsers",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true,
      },
    },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond"
            }
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = notes,
              },
              default_workspace = "notes",
            },
          },
          ["core.keybinds"] = {}, -- Adds default keybindings
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          }, -- Enables support for completion plugins
          ["core.journal"] = {}, -- Enables support for the journal module
          ["core.integrations.nvim-cmp"] = {},
          ["core.integrations.treesitter"] = {
            config = {
              configure_parsers = true,
              install_parsers = true,
            },
          },
          ["core.highlights"] = {}, -- Maps available highlight groups
          ["core.mode"] = {}, -- Mange Neorg modes
        },
      }
    end,
  },
}
