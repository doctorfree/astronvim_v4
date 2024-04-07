---@type LazySpec
return {

  -- Completely override the default astronvim plugin configuration
  -- override alpha options
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = true,
    event = "VimEnter",
    keys = { { "<leader>A", "<cmd>Alpha<CR>", "Alpha Dashboard" } },
    config = function()
      require("configs.alpha")
    end,
  },

  -- Disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- Customize additional setup of plugins that are outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      -- Include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts)
      -- Add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- Don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- Don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- Don't move right when repeat character
            :with_move(cond.none())
            -- Don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- Disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- Disable for .vim files, but it works for other filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- Add and configure additional plugins

  "andweeb/presence.nvim",

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- LSP Cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
    },
    config = function()
      require("configs.nvim-cmp")
    end,
  },
}
