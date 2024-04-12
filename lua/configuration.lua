local conf = {}

-- THEME CONFIGURATION
-- Available themes: catppuccin, dracula, everforest, kanagawa,
--                   monokai-pro nightfox, tokyonight, tundra,
-- A configuration file for each theme is in lua/configs/themes/
-- Use <F8> to step through themes
conf.theme = "tokyonight"
-- Available styles are:
--   catppuccin:  latte, frappe, macchiato, mocha, custom
--   dracula:     blood, magic, soft, default
--   kanagawa:    wave, dragon, lotus
--   monokai-pro: classic, octagon, pro, machine, ristretto, spectrum
--   nightfox:    carbonfox, dawnfox, dayfox, duskfox, nightfox, nordfox, terafox
--   tokyonight:  night, storm, day, moon
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

-- PLUGINS CONFIGURATION
-- Enable the Neotest plugin
conf.enable_neotest = false
-- Enable toggleterm plugin
conf.enable_toggleterm = true
-- Enable the WakaTime metrics dashboard (requires API key)
conf.enable_wakatime = false
-- Enable zen mode distraction-free coding
conf.enable_zenmode = true
-- if zenmode enabled then enable terminal support as well
conf.enable_kitty = false
conf.enable_alacritty = false
conf.enable_wezterm = false

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
-- See https://github.com/nvim-treesitter/nvim-treesitter/wiki/List-of-parsers
conf.treesitter_ensure_installed = {
  "bash",
  "c",
  "cpp",
  "json",
  "jsonc",
  "javascript",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
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
	"clangd",
	"cmake",
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

-- Formatters and linters installed by mason-tool-installer
conf.formatters_linters = {
	"actionlint",
	"gofumpt",
	"goimports",
	"golines",
	"golangci-lint",
	"google-java-format",
	-- "latexindent",
	-- "markdownlint",
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
