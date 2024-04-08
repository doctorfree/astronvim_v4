local settings = require "configuration"
local formatters_linters = settings.formatters_linters
local table_contains = require("utils").table_contains

local use_stylua = {}
if table_contains(formatters_linters, "stylua") then
  use_stylua = { "stylua" }
end
local use_shellcheck = {}
if table_contains(formatters_linters, "shellcheck") then
  use_shellcheck = { "shellcheck" }
end
local use_markdownlint = {}
if table_contains(formatters_linters, "markdownlint") then
  use_markdownlint = { "markdownlint" }
end
local use_yamllint = {}
if table_contains(formatters_linters, "yamllint") then
  use_yamllint = { "yamllint" }
end

local linterConfig = vim.fn.stdpath("config") .. '.linter_configs'
local cfg = {}

function cfg.linterConfigs()
	local lint = require("lint")
	local linters = require("lint").linters

	lint.linters_by_ft = {
		lua = use_stylua,
		css = { "stylelint" },
		sh = use_shellcheck,
		markdown = use_markdownlint,
		yaml = use_yamllint,
		python = { "pylint" },
		gitcommit = {},
		json = {},
		javascript = {},
		typescript = {},
		toml = {},
		text = {},
	}

	-- use for codespell for all except bib and css
	for ft, _ in pairs(lint.linters_by_ft) do
		if ft ~= "bib" and ft ~= "css" then table.insert(lint.linters_by_ft[ft], "codespell") end
	end

	linters.codespell.args = {
		"--ignore-words",
		linterConfig .. "/codespell-ignore.txt",
		"--builtin=rare,clear,informal,code,names,en-GB_to_en-US",
	}

	linters.shellcheck.args = {
		"--shell=bash", -- force to work with zsh
		"--format=json",
		"-",
	}

	linters.yamllint.args = {
		"--config-file",
		linterConfig .. "/yamllint.yaml",
		"--format=parsable",
		"-",
	}

	linters.markdownlint.args = {
		"--disable=no-trailing-spaces", -- not disabled in config, so it's enabled for formatting
		"--disable=no-multiple-blanks",
		"--config=" .. linterConfig .. "/markdownlint.yaml",
	}
end

function cfg.lintTriggers()
	vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "TextChanged", "FocusGained" }, {
		callback = function() vim.defer_fn(require("lint").try_lint, 1) end,
	})

	-- due to auto-save.nvim, we need the custom event "AutoSaveWritePost"
	-- instead of "BufWritePost" to trigger linting to prevent race conditions
	vim.api.nvim_create_autocmd("User", {
		pattern = "AutoSaveWritePost",
		callback = function() require("lint").try_lint() end,
	})
	-- run once on start
	require("lint").try_lint()
end

return cfg
