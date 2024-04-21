# AstroNvim v4

**NOTE:** This is for AstroNvim v4+

A sample configuration for [AstroNvim](https://github.com/AstroNvim/AstroNvim) v4

## Table of Contents

- [Installation](#installation)
  - [Lazyman](#lazyman)
- [Usage](#usage)
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

If `lazyman` is already installed, update it before installing `AstroNvimV4`:

```bash
lazyman -U
```

Alternately, if `lazyman` is not suitable for your environment:

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
format reports.

Several other features make `lazyman` an attractive choice but the primary
attractions are the `nvims` shell function and the interactive menu system.
The `nvims` shell function can be used to easily invoke any `lazyman` installed
Neovim configuration. The interactive menu system in `lazyman` version 3.1.6+
has been augmented with menus to configure `AstroNvimV4` settings, enabled
LSP servers, Formatters, and Plugins.

#### Lazyman Screenshots

<details><summary>Click here to view the

**AstroNvimV4 Management with Lazyman screenshots**

</summary>

If `AstroNvimV4` was installed with `lazyman` an interactive menu system to
manage the `AstroNvimV4` configuration is available in `lazyman`.  To view
the main `AstroNvimV4` configuration menu invoke `lazyman -F anv` or simply
`lazyman` and select the `AstroNvimV4 Config` menu entry:

<div align="center"><p>
<img src="https://raw.githubuwercontent.com/wiki/doctorfree/astronvim_v4/screenshots/lazyman.png" style="width:1165px;height:588px;">
</p>
</div>

<div align="center"><p>
<img src="https://raw.githubuwercontent.com/wiki/doctorfree/astronvim_v4/screenshots/config.png" style="width:1914px;height:1117px;">
</p>
</div>

From here you can configure LSP servers, formatters, linters, and plugins:

<div align="center"><p>
<img src="https://raw.githubuwercontent.com/wiki/doctorfree/astronvim_v4/screenshots/lsp.png" style="width:1914px;height:1117px;">
</p>
</div>

<div align="center"><p>
<img src="https://raw.githubuwercontent.com/wiki/doctorfree/astronvim_v4/screenshots/formatters.png" style="width:1914px;height:1117px;">
</p>
</div>

<div align="center"><p>
<img src="https://raw.githubuwercontent.com/wiki/doctorfree/astronvim_v4/screenshots/plugins.png" style="width:1914px;height:1117px;">
</p>
</div>

</details>

An additional benefit `lazyman` provides is the ability to easily and
quickly explore other Neovim configurations including many `AstroNvim`
configurations. For example, `lazyman -i astronvim` installs and initializes
8 `AstroNvim` configurations. These can be easily explored using `nvims`.

The main downside to using `lazyman` is the time it takes to install all of
the Neovim dependencies including language servers and external utilities.
It can take several minutes for `lazyman` to install and initialize.
Minimalists may eschew `lazyman` in favor of a tedious and error-prone manual
installation of Neovim configurations. Different lanes for different brains!

## Usage

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

- Extensive customization of the AstroNvim v4 files:
  - `lua/plugins/astrocore.lua` : customized globals, options, mappings, and autocmds
  - `lua/plugins/astrolsp.lua` : custom formatters, linters, and language servers
  - `lua/plugins/astroui.lua` : options, icons, and status configuration
- Options, LSP, Formatters, and Plugins configuration in `lua/configuration.lua`
  - Integration with `lazyman` interactive menu system
- Customized `tabline`, `winbar`, and `statusline` with `heirline.nvim`
- Mason installed formatters, linters, language servers
- LSP configuration for several language servers
- Customized `terminal` with autocmds/commands for `lazygit`, `lazyman`, `btop`, more
- AstroNvimV4 Cheat Sheet (open with `<leader>H`)
- Highly customized `alpha.nvim` dashboard
- Support for multiple colorschemes and colorscheme switching
- An icon set for use with several plugins
- Neovim command line customization
- Many [additional plugins](https://github.com/doctorfree/nvim-lazyman/blob/main/info/AstroNvimV4.md) enabled and configured in `lua/plugins`

## Configuration

Neovim options are set in `lua/plugins/astrocore.lua` and `lua/options.lua`.
In addition, some configuration can be specified in the file `lua/configuration.lua`.

The default leader key in `AstroNvimV4` is set to `,`. To modify the leader key
or any of several other settings, edit `lua/configuration.lua`.

<details><summary>Click here to view the

**AstroNvimV4 lua/configuration.lua**

</summary>

```lua
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
```

</details>

