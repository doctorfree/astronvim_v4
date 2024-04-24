local settings = require("configuration")
local cheatsheet = {}
if settings.enable_cheatsheet then
  cheatsheet = {
    "doctorfree/cheatsheet.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local ctactions = require("cheatsheet.telescope.actions")
      require("cheatsheet").setup({
        bundled_cheetsheets = {
          enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
          disabled = { "nerd-fonts" },
        },
        bundled_plugin_cheatsheets = {
          enabled = {
            "auto-session",
            "goto-preview",
            "octo.nvim",
            "telescope.nvim",
            "vim-easy-align",
            "vim-sandwich",
          },
          disabled = { "gitsigns" },
        },
        include_only_installed_plugins = true,
        telescope_mappings = {
          ["<CR>"] = ctactions.select_or_fill_commandline,
          ["<A-CR>"] = ctactions.select_or_execute,
          ["<C-Y>"] = ctactions.copy_cheat_value,
          ["<C-E>"] = ctactions.edit_user_cheatsheet,
        },
      })
    end,
  }
end
local neoscroll = {}
if settings.enable_smooth_scrolling then
  neoscroll = {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("configs.neoscroll")
    end,
  }
end
local twilight = { "folke/twilight.nvim", enabled = false }
local wakatime_type = {}
if settings.enable_wakatime then
  wakatime_type = {
    "wakatime/vim-wakatime",
    lazy = false,
  }
end
local zenmode = { "folke/zen-mode.nvim", enabled = false }
local kitty = false
if settings.enable_kitty then
  kitty = true
end
local alacritty = false
if settings.enable_alacritty then
  alacritty = true
end
local wezterm = false
if settings.enable_wezterm then
  wezterm = true
end
if settings.enable_zenmode then
  twilight = {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  }
  zenmode = {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
        width = function()
          return math.min(120, vim.o.columns * 0.75)
        end,
        height = 0.9,
        options = {
          number = false,
          relativenumber = false,
          foldcolumn = "0",
          list = false,
          showbreak = "NONE",
          signcolumn = "no",
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          cmdheight = 1,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        kitty = {
          enabled = kitty,
          font = "+4",
        },
        alacritty = {
          enabled = alacritty,
          font = "14",
        },
        wezterm = {
          enabled = wezterm,
          font = "+4",
        },
      },
      on_open = function()
        vim.diagnostic.config(require("configs.lsp.diagnostics")["off"])
        vim.g.indent_blankline_enabled = false
      end,
      on_close = function()
        vim.diagnostic.config(require("configs.lsp.diagnostics")["on"])
        vim.g.indent_blankline_enabled = true
      end,
    },
  }

  vim.keymap.set("n", "<leader>z", function()
    require("zen-mode").toggle({})
  end, { desc = "Toggle zen mode" })
end

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
    config = function() require "configs.alpha" end,
  },

  -- Disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- Customize additional setup of plugins that are outside of the plugin's setup call
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("configs.which-key")
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

  -- clangd extensions (such as inlay hints)
  {
    "p00f/clangd_extensions.nvim",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("configs.clangd").setup()
    end,
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
      "saadparwaiz1/cmp_luasnip",
      "p00f/clangd_extensions.nvim",
    },
    config = function() require "configs.nvim-cmp" end,
  },
  {
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    config = function()
      require("configs.package-info")
    end,
  },
  cheatsheet,
  neoscroll,
  twilight,
  wakatime_type,
  zenmode,
}
