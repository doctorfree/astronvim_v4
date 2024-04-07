local settings = require("configuration")
local formatters_linters = settings.formatters_linters
local lsp_servers = settings.lsp_servers

---@type LazySpec
return {
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("configs.navic")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>li"] =
            { "<Cmd>LspInfo<CR>", desc = "LSP information", cond = function() return vim.fn.exists ":LspInfo" > 0 end }
        end,
      },
      { "folke/neoconf.nvim", lazy = true, opts = {} },
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        cmd = { "LspInstall", "LspUninstall" },
        init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
        opts = function(_, opts)
          if not opts.handlers then opts.handlers = {} end
          opts.handlers[1] = function(server) require("astrolsp").lsp_setup(server) end
        end,
      },
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "nvim-lua/plenary.nvim",
      "b0o/SchemaStore.nvim",
      "folke/neodev.nvim",
    },
    cmd = function(_, cmds) -- HACK: lazy load lspconfig on `:Neoconf` if neoconf is available
      if require("astrocore").is_available "neoconf.nvim" then table.insert(cmds, "Neoconf") end
      vim.list_extend(cmds, { "LspInfo", "LspLog", "LspStart" }) -- add normal `nvim-lspconfig` commands
    end,
    event = "User AstroFile",
    config = function(plugin, opts)
      -- Include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.lspconfig"(plugin, opts)
      local masonopts = {
        ensure_installed = formatters_linters,
        ui = {
          border = "rounded",
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ﮊ",
          },
        },
      }
      require("mason").setup(masonopts)
      local mr = require("mason-registry")
      local function install_ensured()
        for _, tool in ipairs(masonopts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(install_ensured)
      else
        install_ensured()
      end
      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
        automatic_installation = false,
      })
      require("configs.lspconfig")
    end,
  },
}

