local conf = {}

-- THEME CONFIGURATION
-- Available themes:
--   nightfox, tokyonight, dracula, kanagawa, catppuccin,
--   tundra, onedarkpro, everforest, monokai-pro
-- A configuration file for each theme is in lua/configs/themes/
-- Use <F8> to step through themes
conf.theme = "tokyonight"
-- Available styles are:
--   kanagawa:    wave, dragon, lotus
--   tokyonight:  night, storm, day, moon
--   onedarkpro:  onedark, onelight, onedark_vivid, onedark_dark
--   catppuccin:  latte, frappe, macchiato, mocha, custom
--   dracula:     blood, magic, soft, default
--   nightfox:    carbonfox, dawnfox, dayfox, duskfox, nightfox, nordfox, terafox
--   monokai-pro: classic, octagon, pro, machine, ristretto, spectrum
conf.theme_style = "moon"
-- enable transparency if the theme supports it
conf.enable_transparent = false

-- GLOBAL OPTIONS CONFIGURATION
-- Some prefer space as the map leader, but why
conf.mapleader = ","
conf.maplocalleader = ","
-- set numbered lines
conf.number = true
-- enable mouse see :h mouse
conf.mouse = "nv"
-- set relative numbered lines
conf.relative_number = true
-- enable or disable listchars
conf.list = true
-- which list chars to show
conf.listchars = {
  eol = "⤶",
  tab = ">.",
  trail = "~",
  extends = "◀",
  precedes = "▶",
}
-- use rg instead of grep
conf.grepprg = "rg --hidden --vimgrep --smart-case --"

-- treesitter parsers to be installed
conf.treesitter_ensure_installed = {
  "bash",
  "lua",
  "markdown",
  "markdown_inline",
  "query",
  "regex",
  "vim",
  "vimdoc",
}
-- Formatters and linters installed by Mason
conf.formatters_linters = {
  "actionlint",
  "gofumpt",
  "goimports",
  "golines",
  "golangci-lint",
  "google-java-format",
  "latexindent",
  "markdownlint",
  -- "debugpy",
  "isort",
  -- "json-lsp",
  "marksman",
  -- "php-debug-adapter",
  -- "php-cs-fixer",
  "prettier",
  "prettierd",
  "pyright",
  "sql-formatter",
  -- "shellcheck",
  "shfmt",
  "stylua",
  "tflint",
  "yamllint",
}
-- Formatters and linters installed externally
conf.external_formatters = {
  "beautysh",
  "black",
  "flake8",
  "ruff",
}

return conf
