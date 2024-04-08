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
-- always show tabs; 0 never, 1 only if at least two tab pages, 2 always
conf.showtabline = 2
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

-- Neorg notes folder
conf.neorg_notes = { "~/Documents/Notes" }
-- Obsidian vault folder (relative to HOME)
conf.obsidian_vault = "Documents/Notes/Obsidian"

-- use rg instead of grep
conf.grepprg = "rg --hidden --vimgrep --smart-case --"

-- Show diagnostics, can be one of "none", "icons", "popup". Default is "popup"
--   "none":  diagnostics are disabled but still underlined
--   "icons": only an icon will show, use ',de' to see the diagnostic
--   "popup": an icon will show and a popup with the diagnostic will appear
conf.show_diagnostics = "popup"

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
-- Formatters and linters installed by mason-tool-installer
conf.formatters_linters = {
  "actionlint",
  "gofumpt",
  "goimports",
  "golines",
  "golangci-lint",
  "google-java-format",
  -- "latexindent",
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
-- Language servers installed by the Lazyman initialization
conf.lsp_installed = {
  "cssls",
  "denols",
  "html",
  "lua_ls",
  "pylsp",
  "pyright",
  "tsserver",
  "vimls",
}
-- Language servers that should be installed by mason-lspconfig
conf.lsp_servers = {
  "bashls",
  -- "cssmodules_ls",
  -- "dockerls",
  -- "emmet_ls",
  -- "eslint",
  -- "gopls",
  -- "graphql",
  -- "jdtls",
  -- "julials",
  -- "ltex",
  "jsonls",
  "marksman",
  -- "prismals",
  -- "sqlls",
  -- "tailwindcss",
  "taplo",
  -- "texlab",
  "vuels",
  "yamlls",
}

return conf
