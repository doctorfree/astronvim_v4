local settings = require("configuration")
local formatters_linters = settings.formatters_linters
local external_formatters = settings.external_formatters
local table_contains = require("utils").table_contains

vim.filetype.add({
  extension = {
    zsh = "zsh",
  },
})

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-shellcheck.nvim",
  },
  opts = function(_, config)
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local actions = null_ls.builtins.code_actions

    -- To enable debug mode, set debug flag to true:
    --     config.debug = true
    -- Use :NullLsLog to open your debug log in the current Neovim instance or
    --     :NullLsInfo to get the path to your debug log

    config.sources = {
      actions.gitsigns,
      diagnostics.zsh.with({ filetypes = { "zsh" } }),
    }
    if table_contains(formatters_linters, "actionlint") then
      table.insert(config.sources, diagnostics.actionlint)
    end
    if table_contains(formatters_linters, "stylua") then
      table.insert(
        config.sources,
        formatting.stylua.with({
          timeout = 10000,
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        })
      )
    end
    if table_contains(formatters_linters, "prettier") then
      table.insert(
        config.sources,
        formatting.prettier.with({
          -- milliseconds
          timeout = 10000,
          extra_args = { "--single-quote", "false" },
        })
      )
    else
      table.insert(config.sources, formatting.eslint_d)
    end
    if table_contains(external_formatters, "ruff") then
      if vim.fn.executable("ruff") == 1 then
        table.insert(config.sources, require("none-ls.diagnostics.ruff"))
      end
    end
    if table_contains(external_formatters, "black") then
      if vim.fn.executable("black") == 1 then
        table.insert(
          config.sources,
          formatting.black.with({
            timeout = 10000,
            extra_args = { "--fast" },
          })
        )
      end
    end
    if table_contains(external_formatters, "beautysh") then
      if vim.fn.executable("beautysh") == 1 then
        table.insert(
          config.sources,
          require("none-ls.formatting.beautysh").with({
            timeout = 10000,
            extra_args = { "--indent-size", "2" },
          })
        )
      end
    end
    if table_contains(external_formatters, "flake8") then
      if vim.fn.executable("flake8") == 1 then
        table.insert(
          config.sources,
          require("none-ls.diagnostics.flake8").with({
            timeout = 10000,
            extra_args = {
              "--ignore=E203,E501,E402,F401,F821,W503,W292",
              "--max-line-length",
              "88",
            },
            filetypes = { "python" },
          })
        )
      end
    end
    if table_contains(formatters_linters, "latexindent") then
      table.insert(
        config.sources,
        -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
        formatting.latexindent.with({
          timeout = 10000,
          extra_args = { "-g", "/dev/null" },
        })
      )
    end
    if table_contains(formatters_linters, "shellcheck") then
      table.insert(
        config.sources,
        require("none-ls-shellcheck.code_actions").with({
          timeout = 10000,
          filetypes = { "sh", "zsh", "bash" },
        })
      )
      table.insert(
        config.sources,
        require("none-ls-shellcheck.diagnostics")
      )
    end
    -- Arguments to shfmt:
    -- -i, --indent <uint>
    --     Indent: 0 for tabs (default), >0 for number of spaces.
    -- -bn, --binary-next-line
    --     Binary ops like && and | may start a line.
    -- -ci, --case-indent
    --     Switch cases will be indented.
    -- -sr, --space-redirects
    --     Redirect operators will be followed by a space.
    -- -kp, --keep-padding
    --     Keep column alignment paddings.
    -- -fn, --func-next-line
    --     Function opening braces are placed on a separate line.
    if table_contains(formatters_linters, "shfmt") then
      table.insert(
        config.sources,
        formatting.shfmt.with({
          timeout = 10000,
          extra_args = { "-i", "2", "-ci", "-bn", "-sr" },
          filetypes = { "sh", "zsh", "bash" },
        })
      )
    end
    if table_contains(formatters_linters, "sql_formatter") then
      table.insert(
        config.sources,
        formatting.sql_formatter.with({
          timeout = 10000,
          extra_args = { "--config" },
        })
      )
    end
    if table_contains(formatters_linters, "markdownlint") then
      table.insert(
        config.sources,
        formatting.markdownlint.with({
          timeout = 10000,
        })
      )
    end
    if settings.enable_coding then
      if table_contains(formatters_linters, "goimports") then
        table.insert(
          config.sources,
          formatting.goimports.with({
            timeout = 10000,
          })
        )
      end
      if table_contains(formatters_linters, "gofumpt") then
        table.insert(
          config.sources,
          formatting.gofumpt.with({
            timeout = 10000,
          })
        )
      end
      if table_contains(formatters_linters, "golines") then
        table.insert(
          config.sources,
          formatting.golines.with({
            timeout = 10000,
          })
        )
      end
      if table_contains(formatters_linters, "google-jave-format") then
        table.insert(
          config.sources,
          formatting.google_java_format.with({
            timeout = 10000,
          })
        )
      end
    end

    return config
  end,
}
