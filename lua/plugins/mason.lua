-- Customize Mason plugins

local settings = require "configuration"
local formatters_linters = settings.formatters_linters
local lsp_servers = settings.lsp_servers
local utils = require "utils.linter"

---@type LazySpec
return {
  -- Use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- Overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- LSP_servers defined in lua/configuration.lua
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, lsp_servers)
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    event = "VeryLazy",
    optional = true,
    config = function()
      -- triggered myself, since `run_on_start`, does not work w/ lazy-loading
      require("mason-tool-installer").setup {
        ensure_installed = formatters_linters,
        run_on_start = false,
      }
      vim.defer_fn(vim.cmd.MasonToolsInstall, 2000)
    end,
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>lv"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
            },
          },
        },
      },
    },
    opts = {},
    cmd = { "VenvSelect", "VenvSelectCached" },
  },

  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python", -- NOTE: ft: lazy-load on filetype
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
      require("dap-python").setup(path, opts)
    end,
  },
  {
    "b0o/SchemaStore.nvim",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        optional = true,
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          config = {
            jsonls = {
              on_new_config = function(config)
                if not config.settings.json.schemas then config.settings.json.schemas = {} end
                vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
              end,
              settings = { json = { validate = { enable = true } } },
            },
            yamlls = {
              on_new_config = function(config)
                config.settings.yaml.schemas = vim.tbl_deep_extend(
                  "force",
                  config.settings.yaml.schemas or {},
                  require("schemastore").yaml.schemas()
                )
              end,
              settings = { yaml = { schemaStore = { enable = false, url = "" } } },
            },
          },
        },
      },
    },
  },
}
