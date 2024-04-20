local settings = require("configuration")
local table_contains = require("utils").table_contains
local bash_enabled = { "bash-language-server", "bash-debug-adapter" }
local shfmt_enabled = {}

if table_contains(settings.external_formatters, "shellcheck") then
  table.insert(bash_enabled, "shellcheck")
end
if table_contains(settings.external_formatters, "shfmt") then
  table.insert(bash_enabled, "shfmt")
end
local conform_opts = {}
if table_contains(settings.external_formatters, "shfmt") then
  shfmt_enabled = { "shfmt" }
  conform_opts = {
    formatters_by_ft = {
      sh = { "shfmt" },
    },
  }
end
local shellcheck_opts = {}
if table_contains(settings.external_formatters, "shellcheck") then
  shellcheck_opts = {
    linters_by_ft = {
      sh = { "shellcheck" },
    },
  }
end

return {
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    config = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, shfmt_enabled)
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "bash" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = conform_opts,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = shellcheck_opts,
  },
}
