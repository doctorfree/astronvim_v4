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
-- Enable display of custom cheatsheets
conf.enable_cheatsheet = true
-- Enable smooth scrolling with neoscroll plugin
conf.enable_smooth_scrolling = true
-- Enable the Neotest plugin
conf.enable_neotest = true
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

-- Enable/disable nvim-treesitter-context
conf.enable_treesitter_context = false
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

-- LSPs that are installed by the Lazyman initialization
-- Leave the 'LSP_SERVERS' trailing comment, it is used by lazyman
conf.lsp_installed = {
  "cssls",    -- LSP_SERVERS
  "denols",   -- LSP_SERVERS
  "html",     -- LSP_SERVERS
  "lua_ls",   -- LSP_SERVERS
  "pylsp",    -- LSP_SERVERS
  "pyright",  -- LSP_SERVERS
  "tsserver", -- LSP_SERVERS
  "vimls",    -- LSP_SERVERS
}
-- LSPs that should be installed by Mason-lspconfig
-- Leave the 'LSP_SERVERS' trailing comment, it is used by lazyman
conf.lsp_servers = {
  "bashls",           -- LSP_SERVERS
  "clangd",           -- LSP_SERVERS
  "cmake",            -- LSP_SERVERS
  -- "cssmodules_ls", -- LSP_SERVERS
  -- "dockerls",      -- LSP_SERVERS
  -- "emmet_ls",      -- LSP_SERVERS
  -- "eslint",        -- LSP_SERVERS
  -- "gopls",         -- LSP_SERVERS
  -- "graphql",       -- LSP_SERVERS
  "jsonls",           -- LSP_SERVERS
  -- "jdtls",         -- LSP_SERVERS
  -- "julials",       -- LSP_SERVERS
  -- "ltex",          -- LSP_SERVERS
  "marksman",         -- LSP_SERVERS
  -- "prismals",      -- LSP_SERVERS
  -- "sqlls",         -- LSP_SERVERS
  -- "tailwindcss",   -- LSP_SERVERS
  "taplo",            -- LSP_SERVERS
  -- "texlab",        -- LSP_SERVERS
  "vuels",            -- LSP_SERVERS
  "yamlls",           -- LSP_SERVERS
}

-- Enable/Disable automatic formatting
conf.enable_autoformat = false
-- Formatters and linters installed by Mason
conf.formatters_linters = {
  "actionlint",           -- FORMATTERS_LINTERS
  -- "debugpy",           -- FORMATTERS_LINTERS
  "gofumpt",              -- FORMATTERS_LINTERS
  "goimports",            -- FORMATTERS_LINTERS
  "golines",              -- FORMATTERS_LINTERS
  "golangci-lint",        -- FORMATTERS_LINTERS
  "google-java-format",   -- FORMATTERS_LINTERS
  "isort",                -- FORMATTERS_LINTERS
  -- "json-lsp",          -- FORMATTERS_LINTERS
  -- "latexindent",       -- FORMATTERS_LINTERS
  -- "markdownlint",      -- FORMATTERS_LINTERS
  "marksman",             -- FORMATTERS_LINTERS
  -- "php-debug-adapter", -- FORMATTERS_LINTERS
  -- "php-cs-fixer",      -- FORMATTERS_LINTERS
  "prettier",             -- FORMATTERS_LINTERS
  "prettierd",            -- FORMATTERS_LINTERS
  "pyright",              -- FORMATTERS_LINTERS
  "sql-formatter",        -- FORMATTERS_LINTERS
  -- "shellcheck",        -- FORMATTERS_LINTERS
  "shfmt",                -- FORMATTERS_LINTERS
  "stylua",               -- FORMATTERS_LINTERS
  "tflint",               -- FORMATTERS_LINTERS
  "yamllint",             -- FORMATTERS_LINTERS
}
-- Formatters and linters installed externally
conf.external_formatters = {
  "beautysh",             -- FORMATTERS_LINTERS
  "black",                -- FORMATTERS_LINTERS
  "flake8",               -- FORMATTERS_LINTERS
  "ruff",                 -- FORMATTERS_LINTERS
}

return conf
