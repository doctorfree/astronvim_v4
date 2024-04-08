# AstroNvim v4

**NOTE:** This is for AstroNvim v4+

A sample configuration for [AstroNvim](https://github.com/AstroNvim/AstroNvim) v4

## Table of Contents

- [Installation](#installation)
  - [Lazyman](#lazyman)
- [Run](#run)
- [Features](#features)
- [Configuration](#configuration)

## Installation

This Neovim configuration can be installed using the
[Lazyman Neovim Configuration Manager](https://lazyman.dev):

```bash
# Install lazyman with the following two commands:
git clone https://github.com/doctorfree/nvim-lazyman $HOME/.config/nvim-Lazyman
$HOME/.config/nvim-Lazyman/lazyman.sh
# Install and initialize this configuration with the following command:
lazyman -x AstroNvimV4
```

Alternately, if `lazyman` is not installed:

```bash
git clone https://github.com/doctorfree/astronvim_v4 $HOME/.config/nvim-AstroNvimV4
NVIM_APPNAME=nvim-AstroNvimV4 nvim --headless "+Lazy! sync" +qa
```

**Note:** Manual installation may require additional dependencies to be installed.
Use `lazyman` to automatically install dependencies and initialize Neovim configurations.

### Lazyman

The recommended installation procedure is with the
[Lazyman Neovim Configuration Manager](https://lazyman.dev).
Installing with `lazyman` ensures dependencies are met, initialization is
automated, updates/removal/reinstallation can be performed easily, and
configuration is site-specific for some settings. Lazyman can perform
health checks, launching, updates, and generation of HTML and markdown
format reports. Several other features make `lazyman` an attractive choice
but the primary attraction is the `nvims` shell function which can be used
to easily invoke any `lazyman` installed Neovim configuration.

An additional benefit `lazyman` provides is the ability to easily and
quickly explore other Neovim configurations including many `AstroNvim`
configurations. For example, `lazyman -i astronvim` installs and initializes
8 `AstroNvim` configurations. These can be easily explored using `nvims`.

The main downside to using `lazyman` is the time it takes to install all of
the Neovim dependencies including language servers and external utilities.
It can take several minutes for `lazyman` to install and initialize.
Minimalists may eschew `lazyman` in favor of a tedious and error-prone manual
installation of Neovim configurations. Different lanes for different brains!

## Run

If using `lazyman`, the `nvims` shell function can be used to select `AstroNvimV4`:

```bash
nvims
# Or edit a file(s)
nvims foobar.lua
# Fuzzy select AstroNvimV4 by typing 'ast' and <Enter>
```

After selecting a configuration with `nvims` an alias is set so subsequent
invocations can be performed using `vi` until the current shell is exited.

Alternately, set `NVIM_APPNAME`:

```bash
export NVIM_APPNAME="nvim-AstroNvimV4"
nvim
```

## Features

`AstroNvimV4` is based on the AstroNvim v4 template at <https://github.com/AstroNvim/template>

The LSP configuration in `AstroNvimV4` leverages the configuration in the
default `Lazyman` configuration. Much of that LSP configuration, handlers,
capabilities, `on_attach` function, diagnostics, and more have been integrated
into the `AstroNvim` v4 `lua/plugins/astrolsp.lua` in `AstroNvimV4`. As such,
this example configuration may serve as a guide to some advanced LSP
configuration in `AstroNvim` v4.

Beyond the basic features provided by this template, `AstroNvimV4` includes:

- Options and plugin configuration in `lua/options.lua` and `lua/configuration.lua`
- Mason installed formatters, linters, language servers
- LSP configuration for several language servers
- Customized `terminal` with autocmds/commands for `lazygit`, `lazyman`, `htop`
- Highly customized `alpha.nvim` dashboard
- Support for multiple colorschemes and colorscheme switching
- An icon set for use with several plugins
- Neovim command line customization
- Many additional plugins enabled in `lua/plugins`:
  - autocomplete.lua
  - bufferline.lua
  - cmp-cmdline.lua
  - editor-behavior.lua
  - icons.lua
  - motion.lua
  - neogit.lua
  - neotest.lua
  - notes.lua
  - null-ls.lua
  - nvim-dap.lua
  - statuslines.lua
  - syntax.lua
  - telescope.lua
  - themes.lua
  - ui.lua

## Configuration

Neovim options are set in `lua/options.lua`. In addition, some configuration can
be specified in the file `lua/configuration.lua`.

The default leader key in `AstroNvimV4` is set to `,`. To modify the leader key
or any of several other settings, edit `lua/configuration.lua`.

```lua
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
```
