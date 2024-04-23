# AstroNvimV4

An advanced configuration for [AstroNvim V4](https://github.com/AstroNvim/AstroNvim)

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/diagnostic.png" style="width:1116px;height:582px;">
</p>
</div>

## Table of Contents

- [Installation](#installation)
  - [Lazyman](#lazyman)
  - [Lazyman Screenshots](#lazyman-screenshots)
  - [Update](#update)
  - [Remove](#remove)
- [Features](#features)
- [Configuration](#configuration)
- [Usage](#usage)
  - [Cheatsheet](#cheatsheet)
  - [Keymaps](#keymaps)
  - [Language Servers](#language-servers)

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

`Lazyman` provides the ability to easily and quickly explore Neovim
configurations including many `AstroNvim` configurations. For example,
`lazyman -i astronvim` installs and initializes 8 `AstroNvim` configurations.
These can be easily explored using the `nvims` shell function.

Several other features make `lazyman` an attractive choice but the primary
attractions are the `nvims` shell function and the interactive menu system.
The `nvims` shell function can be used to easily invoke any `lazyman` installed
Neovim configuration. The interactive menu system in `lazyman` version 3.1.6+
has been augmented with menus to configure `AstroNvimV4` settings, enabled
LSP servers, Formatters, and Plugins.

#### Lazyman Screenshots

If `AstroNvimV4` was installed with `lazyman` an interactive menu system to
manage the `AstroNvimV4` configuration is available in `lazyman`. To view
the main `AstroNvimV4` configuration menu invoke `lazyman -F anv` or simply
`lazyman` and select the `AstroNvimV4 Config` menu entry:

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/lazyman.png" style="width:1165px;height:588px;">
</p>
</div>

<details><summary>Click here to view the AstroNvimV4

**Management with Lazyman screenshots**

</summary>

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/config.png" style="width:957px;height:558px;">
</p>
</div>

From here you can configure LSP servers, formatters, linters, and plugins:

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/lsp.png" style="width:957px;height:558px;">
</p>
</div>

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/formatters.png" style="width:957px;height:558px;">
</p>
</div>

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/plugins.png" style="width:957px;height:558px;">
</p>
</div>

</details>

### Update

The `AstroNvimV4` Neovim configuration can be updated with the command:

```bash
lazyman -U -N AstroNvimV4
```

In the absence of `lazyman` a manual update can be performed with:

```bash
git -C ~/.config/nvim-AstroNvimV4 pull
```

### Remove

The `AstroNvimV4` Neovim configuration, plugins, data, and cache can be removed
with the command:

```bash
lazyman -R -N AstroNvimV4
```

In the absence of `lazyman` a manual removal can be performed with:

```bash
rm -rf ~/.local/share/nvim-AstroNvimV4
rm -rf ~/.local/state/nvim-AstroNvimV4
rm -rf ~/.cache/nvim-AstroNvimV4
rm -rf ~/.config/nvim-AstroNvimV4
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
```

</details>

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

### Cheatsheet

View the `AstroNvimV4` fuzzy searchable cheatsheet with `<leader>H`

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/cheatsheet.png" style="width:1116px;height:582px;">
</p>
</div>

### Keymaps

View Keymaps with `<leader>` (`comma` is the default leader key in `AstroNvimV4`).

`AstroNvimV4` key mappings are defined in `lua/plugins/astrocore.lua`.

<details><summary>Click here to view the AstroNvimV4

**lua/plugins/astrocore.lua**

</summary>

```lua
local settings = require("configuration")
local icons = require("icons")
local Util = require("utils")
local plugin = require("utils.plugin")
local Info = require("lazy.core.util").info
local diagnostic_goto = require("configs.lsp.keymaps").diagnostic_goto
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3

local cheat = {}
if settings.enable_cheatsheet then
  cheat = { "<cmd>Cheatsheet<CR>", desc = "AstroNvimV4 Cheatsheet" }
end
local top = {}
if vim.fn.executable "btop" == 1 then
  top = { "<cmd>Top<CR>", desc = "System Monitor" }
else
  if vim.fn.executable "htop" == 1 then
    top = { "<cmd>Top<CR>", desc = "System Monitor" }
  end
end
local git = {}
if vim.fn.executable "lazygit" == 1 then
  git = { "<cmd>Lazygit<CR>", desc = "Lazygit Command" }
end
local lman = {}
local lconf = {}
local lplug = {}
local lform = {}
local llsp = {}
if vim.fn.executable "lazyman" == 1 then
  lman = { "<cmd>Lazyman<CR>", desc = "Lazyman Menu" }
  lconf = { "<cmd>Astroconf<CR>", desc = "AstroNvimV4 Configuration" }
  lplug = { "<cmd>Astroplug<CR>", desc = "AstroNvimV4 Plugins" }
  lform = { "<cmd>Astroform<CR>", desc = "AstroNvimV4 Formatters" }
  llsp = { "<cmd>Astrolsp<CR>", desc = "AstroNvimV4 LSP Servers" }
end
local ascii = {}
if vim.fn.executable "asciiville" == 1 then
  ascii = { "<cmd>Asciiville<CR>", desc = "Asciiville" }
end
local mpplus = {}
local mpmenu = {}
if vim.fn.executable "mpplus" == 1 then
  mpplus = { "<cmd>MusicPlayerPlus<CR>", desc = "MusicPlayerPlus" }
  mpmenu = { "<cmd>MusicPlayerMenu<CR>", desc = "MusicPlayerPlus Menu" }
end

require("keymaps")
require("options")

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options are configured in lua/options.lua
    options = {
      opt = {
        clipboard = "unnamed", --- Copy-paste between vim and everything else
        cmdheight = 0, --- Give more space for displaying messages
        completeopt = "menu,menuone,noselect", --- Better autocompletion
        cursorline = true, --- Highlight of current line
        emoji = false, --- Fix emoji display
        expandtab = true, --- Use spaces instead of tabs
        foldcolumn = "0",
        foldnestmax = 0,
        foldmethod = "expr",
        foldexpr = "nvim_treesitter#foldexpr()",
        foldlevel = 99, --- Using ufo provider need a large value
        foldlevelstart = 99, --- Expand all folds by default
        ignorecase = true, --- Needed for smartcase
        laststatus = 3, --- Global statusline at the bottom
        list = settings.list,
        listchars = settings.listchars,
        mouse = settings.mouse, --- Enable mouse
        number = settings.number, --- Shows current line number
        relativenumber = settings.relative_number, --- Enables relative number
        pumheight = 10, --- Max num of items in completion menu
        scrolloff = 8, --- Always keep space when scrolling to bottom/top edge
        shiftwidth = 2, --- Number of space characters inserted for indentation
        showtabline = settings.showtabline, --- Always show tabs
        spell = false, -- sets vim.opt.spell
        -- signcolumn  = "auto", -- sets vim.opt.signcolumn to auto
        signcolumn = "yes:2", --- Add extra sign column next to line number
        smartcase = true, --- Uses case in search
        smartindent = true, --- Makes indenting smart
        smarttab = true, --- Makes tabbing smarter will realize you have 2 vs 4
        softtabstop = 2, --- Insert 2 spaces for a tab
        splitright = true, --- Vertical splits will automatically be to the right
        swapfile = false, --- Swap not needed
        tabstop = 2, --- Insert 2 spaces for a tab
        termguicolors = true, --- Correct terminal colors
        timeoutlen = 300, --- Faster completion (cannot be lower than 200)
        ttimeoutlen = 0, --- Time to wait for a key code sequence to complete
        undofile = true, --- Sets undo to file
        updatetime = 100, --- Faster completion
        viminfo = "'1000", --- Increase the size of file history
        wildignore = "*node_modules/**", --- Don't search inside Node.js modules (works for gutentag)
        wrap = true, --- Display long lines as just one line
        writebackup = false, --- Not needed
        -- Neovim defaults
        autoindent = true, --- Good auto indent
        backspace = "indent,eol,start", --- Making sure backspace works
        backup = false, --- Recommended by coc
        -- Concealed text is completely hidden unless it has a custom replacement
        -- character defined (needed for dynamically showing tailwind classes)
        conceallevel = 2,
        concealcursor = "", --- Set to an empty string to expand tailwind class when on cursorline
        encoding = "utf-8", --- The encoding displayed
        errorbells = false, --- Disables sound effect for errors
        fileencoding = "utf-8", --- The encoding written to file
        incsearch = true, --- Start searching before pressing enter
        showmode = false, --- Don't show things like -- INSERT -- anymore
      },
      g = {
        speeddating_no_mappings = 1, --- Disable default mappings for speeddating
        autoformat_enabled = settings.enable_autoformat, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
        diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        camelcasemotion_key = "<Leader>",
        loaded_perl_provider = 0,
        sonokai_style = "andromeda",
      },
    },
    -- Keymaps are spread all over Hell's halfacre in Neovim configurations.
    -- While I appreciate the effort to centralize them here, this work is not yet
    -- complete in this configuration. Mappings for this configuration are specified
    -- in lua/keymaps.lua, lua/configs/which-key.lua, and various plugin configurations.
    --
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs.
    -- For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- Tables with just a `desc` key will be registered with which-key if it's installed
        -- This is useful for naming menus
        ["<Leader>b"] = { desc = icons.ui.Table .. "Buffers" },
        ["<Leader>t"] = { desc = icons.ui.Terminal .. "Terminal" },
        ["<Leader><tab>"] = { desc = icons.ui.Terminal .. "Tabs" },
        ["<Leader>w"] = { desc = icons.ui.Terminal .. "Windows" },
        ["<Leader>W"] = { desc = icons.ui.Terminal .. "Workspaces" },
        ["<Leader>,"] = { desc = icons.kinds.Color .. " Commands/Themes" },
        ["<Leader>."] = { desc = icons.kinds.Color .. " Toggle Keymaps" },

        ["gh"] = {
          "<cmd>OpenRepo<CR>",
          desc = "Open URL",
        },
        -- mappings seen under group name "Buffers"
        ["<Leader>bc"] = {
          function()
            require("astrocore.buffer").close()
          end,
          desc = "Close buffer",
        },
        ["<Leader>bC"] = {
          function()
            require("astrocore.buffer").close(0, true)
          end,
          desc = "Force close buffer",
        },
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              require("astrocore.buffer").close(bufnr)
            end)
          end,
          desc = "Pick to close",
        },

        -- AstroNvimV4 Cheatsheet
        ["<leader>,C"] = cheat,
        ["<leader>H"] = cheat,

        -- Telescope
        ["<Leader>C"] = {
          "<cmd>Telescope command_palette<CR>",
          desc = "Command palette",
        },
        ["<Leader>,T"] = {
          "<cmd>Telescope themes<CR>",
          desc = "Theme Switcher",
        },
        ["<Leader>,c"] = {
          "<cmd>Telescope colorscheme<CR>",
          desc = "Color Schemes",
        },

        -- AstroNvimV4 custom mappings
        ["<Leader>,d"] = {
          "<cmd>Alpha<CR>",
          desc = "Open Dashboard",
        },
        ["<Leader>A"] = {
          "<cmd>Alpha<CR>",
          desc = "Open Dashboard",
        },
        ["<Leader>M"] = {
          "<cmd>Mason<CR>",
          desc = "Manage Packages",
        },
        ["<Leader>,p"] = {
          "<cmd>Lazy<CR>",
          desc = "Manage Plugins",
        },
        ["<Leader>P"] = {
          "<cmd>Lazy<CR>",
          desc = "Manage Plugins",
        },
        ["<Leader>,u"] = {
          "<cmd>Lazy update<CR>",
          desc = "Update Plugins",
        },
        ["<Leader>,q"] = {
          "<cmd>qa<CR>",
          desc = "Quit All",
        },

        -- Plugin Management
        ["<Leader>U"] = {
          "<cmd>Lazy update<CR>",
          desc = "Update Plugins",
        },
        -- Options
        ["<Leader>O"] = {
          "<cmd>options<CR>",
          desc = "Options",
        },
        ["<Leader>,o"] = {
          "<cmd>options<CR>",
          desc = "Options",
        },
        -- Terminal commands
        ["<Leader>,s"] = top,
        ["<Leader>,g"] = git,
        ["<Leader>,l"] = lman,
        ["<Leader>,a"] = lconf,
        ["<Leader>,P"] = lplug,
        ["<Leader>,F"] = lform,
        ["<Leader>,L"] = llsp,
        ["<Leader>,A"] = ascii,
        ["<Leader>,m"] = mpplus,
        ["<Leader>,M"] = mpmenu,
        ["<Leader>,O"] = {
          "<cmd>OpenRepo<CR>",
          desc = "Open URL",
        },
        -- Tabs
        ["<Leader><tab>l"] = {
          "<cmd>tablast<CR>",
          desc = "Last Tab",
        },
        ["<Leader><tab>f"] = {
          "<cmd>tabfirst<CR>",
          desc = "First Tab",
        },
        ["<Leader><tab><tab>"] = {
          "<cmd>tabnew<CR>",
          desc = "New Tab",
        },
        ["<Leader><tab>]"] = {
          "<cmd>tabnext<CR>",
          desc = "Next Tab",
        },
        ["<Leader><tab>d"] = {
          "<cmd>tabclose<CR>",
          desc = "Close Tab",
        },
        ["<Leader><tab>["] = {
          "<cmd>tabprevious<CR>",
          desc = "Previous Tab",
        },
        -- Windows
        ["<Leader>ww"] = {
          "<C-W>p",
          desc = "Other window",
        },
        ["<Leader>wd"] = {
          "<C-W>c",
          desc = "Delete window",
        },
        ["<Leader>w-"] = {
          "<C-W>s",
          desc = "Split window below",
        },
        ["<Leader>w|"] = {
          "<C-W>v",
          desc = "Split window right",
        },
        -- Resize window using <ctrl> arrow keys
        ["<C-Up>"] = {
          "<cmd>resize +2<CR>",
          desc = "Increase window height",
        },
        ["<C-Down>"] = {
          "<cmd>resize -2<CR>",
          desc = "Decrease window height",
        },
        ["<C-Left>"] = {
          "<cmd>vertical resize -2<CR>",
          desc = "Decrease window width",
        },
        ["<C-Right>"] = {
          "<cmd>vertical resize +2<CR>",
          desc = "Increase window width",
        },

        -- Toggle keymaps
        ["<Leader>.f"] = {
          require("configs.lsp.format").toggle,
          desc = "Toggle Format on Save",
        },
        ["<Leader>.s"] = {
          function()
            Util.toggle "spell"
          end,
          desc = "Toggle Spelling",
        },
        ["<Leader>.w"] = {
          function()
            Util.toggle "wrap"
          end,
          desc = "Toggle Word Wrap",
        },
        ["<Leader>.l"] = {
          function()
            Util.toggle("relativenumber", true)
            Util.toggle "number"
          end,
          desc = "Toggle Line Numbers",
        },
        ["<Leader>.c"] = {
          function()
            Util.toggle("conceallevel", false, { 0, conceallevel })
          end,
          desc = "Toggle Conceal",
        },
        ["<Leader>.g"] = {
          function()
            if vim.wo.signcolumn == "no" then
              vim.wo.signcolumn = "yes"
            elseif vim.wo.signcolumn == "yes" then
              vim.wo.signcolumn = "auto"
            else
              vim.wo.signcolumn = "no"
            end
            Info("Set signcolumn to " .. vim.wo.signcolumn, { title = "Option" })
          end,
          desc = "Toggle Signcolumn",
        },

        ["<Leader>.L"] = {
          function()
            vim.opt.showtabline = vim.api.nvim_get_option "showtabline" == 0 and 2 or 0
            Info("Set showtabline to " .. vim.api.nvim_get_option "showtabline", { title = "Option" })
          end,
          desc = "Toggle Tabline",
        },

        --      ["<Leader>.W"] = {
        --        function()
        --          vim.opt.winbar = vim.api.nvim_get_option "winbar" == "" and "1" or ""
        --          Info("Set winbar to " .. vim.api.nvim_get_option "winbar", { title = "Option" })
        --        end,
        --        desc = "Toggle Winbar",
        --      },

        ["<Leader>.S"] = {
          function()
            local laststatus = vim.api.nvim_get_option "laststatus"
            if laststatus == 0 then
              vim.opt.laststatus = 2
            elseif laststatus == 2 then
              vim.opt.laststatus = 3
            elseif laststatus == 3 then
              vim.opt.laststatus = 0
            end
            Info("Set laststatus to " .. vim.api.nvim_get_option "laststatus", { title = "Option" })
          end,
          desc = "Toggle Statusline",
        },

        ["<Leader>.m"] = {
          function()
            local mouse = vim.api.nvim_get_option "mouse"
            if mouse == "" then
              vim.opt.mouse = "nv"
              Info("Mouse Enabled: mouse = " .. vim.api.nvim_get_option "mouse", { title = "Option" })
            else
              vim.opt.mouse = ""
              Info("Mouse Disabled", { title = "Option" })
            end
          end,
          desc = "Toggle Mouse",
        },

        ["<Leader>.N"] = {
          function()
            local number = vim.wo.number -- local to window
            local relativenumber = vim.wo.relativenumber -- local to window
            if not number and not relativenumber then
              vim.wo.number = true
              Info("Set number to true", { title = "Option" })
            elseif number and not relativenumber then
              vim.wo.relativenumber = true
              Info("Set relativenumber to true", { title = "Option" })
            elseif number and relativenumber then
              vim.wo.number = false
              Info("Set number to false", { title = "Option" })
            else -- not number and relativenumber
              vim.wo.relativenumber = false
              Info("Set relativenumber to false", { title = "Option" })
            end
          end,
          desc = "Toggle Number",
        },
        ["<Leader>.x"] = {
          require("utils.functions").toggle_colorcolumn,
          desc = "Toggle Colorcolumn",
        },

        -- Workspaces
        ["<Leader>Wa"] = {
          vim.lsp.buf.add_workspace_folder,
          desc = "add workspace folder",
        },
        ["<Leader>Wr"] = {
          vim.lsp.buf.remove_workspace_folder,
          desc = "remove workspace folder",
        },
        ["<Leader>Wl"] = {
          function()
            vim.print(vim.lsp.buf.list_workspace_folders())
          end,
          desc = "list workspace folder",
        },
        -- LSP
        ["<C-Space>"] = {
          "<cmd>lua vim.lsp.buf.code_action()<CR>",
          desc = "Code Action",
        },
        ["<Leader>ca"] = {
          "<cmd>lua vim.lsp.buf.code_action()<CR>",
          desc = "Code Action",
        },
        ["<Leader>cr"] = {
          "<cmd>lua vim.lsp.buf.rename()<CR>",
          desc = "Rename",
        },
        ["<Leader>cf"] = {
          "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
          desc = "Format",
        },
        ["<Leader>ci"] = {
          "<cmd>LspInfo<CR>",
          desc = "LSP Info",
        },
        ["<Leader>cg"] = {
          "<cmd>Telescope lsp_definitions<CR>",
          desc = "Goto Definition",
        },
        ["<Leader>cR"] = {
          "<cmd>Telescope lsp_references<CR>",
          desc = "References",
        },
        ["<Leader>cG"] = {
          vim.lsp.buf.declaration,
          desc = "Goto Declaration",
        },
        ["<Leader>cI"] = {
          "<cmd>Telescope lsp_implementations<CR>",
          desc = "Goto Implementation",
        },
        ["<Leader>cT"] = {
          "<cmd>Telescope lsp_type_definitions<CR>",
          desc = "Goto Type Definition",
        },
        ["<Leader>ck"] = {
          vim.lsp.buf.hover,
          desc = "Hover",
        },
        ["<Leader>cK"] = {
          vim.lsp.buf.signature_help,
          desc = "Signature Help",
        },
        ["<Leader>cn"] = {
          diagnostic_goto(true),
          desc = "Next Diagnostic",
        },
        ["<Leader>cp"] = {
          diagnostic_goto(false),
          desc = "Prev Diagnostic",
        },
        ["<Leader>ce"] = {
          diagnostic_goto(true, "ERROR"),
          desc = "Next Error",
        },
        ["<Leader>cE"] = {
          diagnostic_goto(false, "ERROR"),
          desc = "Prev Error",
        },
        ["<Leader>cw"] = {
          diagnostic_goto(true, "WARN"),
          desc = "Next Warning",
        },
        ["<Leader>cW"] = {
          diagnostic_goto(false, "WARN"),
          desc = "Prev Warning",
        },
        -- Noice
        ["<Leader>sna"] = {
          "<cmd>Noice<CR>",
          desc = "Noice All",
        },
        ["<Leader>snl"] = {
          "<cmd>NoiceLast<CR>",
          desc = "Noice Last Message",
        },
        ["<Leader>snh"] = {
          "<cmd>NoiceHistory<CR>",
          desc = "Noice History",
        },
        ["<Leader>snL"] = {
          "<cmd>NoiceLog<CR>",
          desc = "Noice Log",
        },
        ["<Leader>sne"] = {
          "<cmd>NoiceErrors<CR>",
          desc = "Noice Errors",
        },
        ["<Leader>snf"] = {
          "<cmd>NoiceTelescope<CR>",
          desc = "Filter Noice",
        },
      },
      v = {
        ["<Leader>ca"] = {
          "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>",
          desc = "Code Action",
        },
        ["<Leader>cf"] = {
          function()
            local start_row, _ = table.unpack(vim.api.nvim_buf_get_mark(0, "<"))
            local end_row, _ = table.unpack(vim.api.nvim_buf_get_mark(0, ">"))
            vim.lsp.buf.format {
              range = {
                ["start"] = { start_row, 0 },
                ["end"] = { end_row, 0 },
              },
              async = true,
            }
          end,
          desc = "Format Range",
        },
      },
    },
    autocmds = {
      -- autocommands are organized into augroups for easy management
      autohidetabline = {
        -- each augroup contains a list of auto commands
        {
          -- create a new autocmd on the "User" event
          event = "User",
          -- the pattern is the name of our User autocommand events
          pattern = "AstroBufsUpdated", -- triggered when vim.t.bufs is updated
          -- nice description
          desc = "Hide tabline when only one buffer and one tab",
          -- add the autocmd to the newly created augroup
          group = "autohidetabline",
          callback = function()
            -- if there is more than one buffer in the tab, show the tabline
            -- if there are 0 or 1 buffers in the tab, only show the tabline if there is more than one vim tab
            local new_showtabline = #vim.t.bufs > 1 and 2 or 1
            -- check if the new value is the same as the current value
            if new_showtabline ~= vim.opt.showtabline:get() then
              -- if it is different, then set the new `showtabline` value
              vim.opt.showtabline = new_showtabline
            end
          end,
        },
      },
      astronvimv4 = {
        {
          event = { "BufRead", "BufNewFile" },
          pattern = "*/node_modules/*",
          desc = "Disable diagnostics in node_modules",
          group = "astronvimv4",
          command = "lua vim.diagnostic.disable(0)",
        },
        {
          event = { "BufRead", "BufNewFile" },
          pattern = { "*.txt", "*.md", "*.tex" },
          desc = "Enable spell checking for certain file types",
          group = "astronvimv4",
          command = "setlocal spell",
        },
        {
          event = { "BufRead", "BufNewFile" },
          pattern = { "*.txt", "*.md", "*.json" },
          desc = "Show `` in specific files",
          group = "astronvimv4",
          command = "setlocal conceallevel=0",
        },
        {
          event = { "WinEnter", "BufWinEnter", "TermOpen" },
          desc = "Auto insert mode for Terminal",
          group = "astronvimv4",
          callback = function(args)
            if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
              vim.opt_local.wrap = true
              vim.opt_local.spell = false
              vim.cmd "startinsert"
            end
          end,
        },
        {
          event = { "TermOpen" },
          desc = "Disable line numbers and columns for Terminal",
          group = "astronvimv4",
          pattern = { "*" },
          callback = function()
            vim.opt_local["number"] = false
            vim.opt_local["relativenumber"] = false
            vim.opt_local["signcolumn"] = "no"
            vim.opt_local["foldcolumn"] = "0"
            vim.opt_local["winhl"] = "Normal:NormalFloat"
          end,
        },
        {
          event = { "VimResized" },
          desc = "Resize splits if window got resized",
          group = "astronvimv4",
          callback = function()
            vim.cmd "tabdo wincmd ="
          end,
        },
        {
          event = { "UIEnter" },
          once = true,
          desc = "Get GUI config when entering UI",
          group = "astronvimv4",
          callback = function()
            require("ginit")
          end,
        },
      },
    },
    commands = {
      -- key is the command name
      -- AstroReload = {
      -- first element with no key is the command (string or function)
      -- function() require("astrocore").reload() end,
      -- the rest are options for creating user commands (:h nvim_create_user_command)
      -- desc = "Reload AstroNvim (Experimental)",
      -- },
      --- Toggle monochrome mode
      MonochromeModeToggle = {
        function()
          if settings.theme == "monokai-pro" then
            local monochrome_element = "neo-tree"
            local mnk_config = require("monokai-pro.config")
            local mnk_opts = plugin.opts("monokai-pro.nvim")
            local bg_clear_list = mnk_opts.background_clear or {}
            local is_monochrome_mode = vim.tbl_contains(bg_clear_list, monochrome_element)
            if is_monochrome_mode then
              -- stylua: ignore
              bg_clear_list = vim.tbl_filter(function(value) return value ~= monochrome_element end, bg_clear_list)
            else
              vim.list_extend(bg_clear_list, { monochrome_element })
            end
            mnk_config.extend({ background_clear = bg_clear_list })
            vim.cmd([[colorscheme monokai-pro]])
          end
        end,
        desc = "Toggle monochrome mode",
      },
      -- Open the URL of the plugin spec or 'user/repo' path under the cursor
      OpenRepo = {
        function()
          local ghpath = vim.api.nvim_eval("shellescape(expand('<cfile>'))")
          local formatpath = ghpath:sub(2, #ghpath - 1)
          local repourl = "https://www.github.com/" .. formatpath
          if formatpath:sub(1, 5) == "http:" or formatpath:sub(1, 6) == "https:" then
            repourl = formatpath
          end
          if vim.fn.has("mac") == 1 then
            vim.fn.system({ "open", repourl })
          else
            if vim.fn.executable("gio") then
              vim.fn.system({ "gio", "open", repourl })
            else
              vim.fn.system({ "xdg-open", repourl })
            end
          end
        end,
        desc = "Open URL",
      },
    },
  },
}
```

</details>

The `which-key` menus can be viewed with `<leader>` (`comma` is the default leader key in `AstroNvimV4`):

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/Keymaps.png" style="width:806px;height:483px;">
</p>
</div>

<details><summary>Click here to view more AstroNvimV4

**Keymaps screenshots**

</summary>

Command and Themes keymaps (view with `<leader>,`)

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/Command_Keymaps.png" style="width:806px;height:483px;">
</p>
</div>

Toggle keymaps (view with `<leader>.`)

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/Toggle_Keymaps.png" style="width:806px;height:483px;">
</p>
</div>

UI/UX and more toggle keymaps (view with `<leader>u`)

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/UI.png" style="width:1780px;height:720px;">
</p>
</div>

Git keymaps (view with `<leader>g`)

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/git.png" style="width:1116px;height:582px;">
</p>
</div>

</details>

### Language Servers

View LSP info with the command `:LspInfo` and LSP key mappings with `<leader>c`.

`AstroNvimV4` LSP servers and formatters are configured in `lua/plugins/astrolsp.lua`.

<details><summary>Click here to view the AstroNvimV4

**lua/plugins/astrolsp.lua**

</summary>

```lua
local settings = require "configuration"
local lsp_servers = settings.lsp_servers
local lsp_installed = settings.lsp_installed
local lsp_all = require("utils").concat_tables(lsp_servers, lsp_installed)
local formatters_linters = settings.formatters_linters
local external_formatters = settings.external_formatters
local table_contains = require("utils").table_contains
local fn = vim.fn
local api = vim.api

-- disable formatting capabilities for the listed language servers
local disable_format = {}
if table_contains(formatters_linters, "stylua") then
  -- disable lua_ls formatting capability when using StyLua to format lua code
  disable_format = { "lua_ls" }
end

local bashls_enabled = { enabled = false }
local bashls_settings = {}
if table_contains(lsp_all, "bashls") then
  bashls_settings = {
    bashIde = {
      backgroundAnalysisMaxFiles = 500,
      enableSourceErrorDiagnostics = false,
      explainshellEndpoint = "",
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
      includeAllWorkspaceSymbols = false,
      logLevel = "info",
      shellcheckArguments = "",
      shellcheckPath = vim.env.SHELLCHECK_PATH or "",
    },
  }
  if table_contains(formatters_linters, "shellcheck") then
    bashls_settings = {
      bashIde = {
        backgroundAnalysisMaxFiles = 500,
        enableSourceErrorDiagnostics = false,
        explainshellEndpoint = "",
        globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
        includeAllWorkspaceSymbols = false,
        logLevel = "info",
        shellcheckArguments = "",
        shellcheckPath = vim.env.SHELLCHECK_PATH or "shellcheck",
      },
    }
  end
  bashls_enabled = { settings = bashls_settings }
end

local venv_path = os.getenv "VIRTUAL_ENV"
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  py_path = vim.g.python3_host_prog
end
local enable_black = { enabled = false }
if table_contains(external_formatters, "black") then
  enable_black = { enabled = true }
end
local enable_ruff = { enabled = false }
if table_contains(external_formatters, "ruff") then
  enable_ruff = { enabled = true }
end

local pylsp_enabled = { enabled = false }
if table_contains(lsp_all, "pylsp") then
  pylsp_enabled = {
    settings = {
      pylsp = {
        plugins = {
          -- formatter options
          black = enable_black,
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- linter options
          pylint = { enabled = false },
          ruff = enable_ruff,
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          -- type checker
          pylsp_mypy = {
            enabled = true,
            overrides = { "--python-executable", py_path, true },
            report_progress = true,
            live_mode = false,
          },
          -- auto-completion options
          jedi_completion = { fuzzy = true },
          -- import sorting
          isort = { enabled = true },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
  }
end
local pyright_enabled = { enabled = false }
if table_contains(lsp_all, "pyright") then
  pyright_enabled = {
    settings = {
      python = {
        analysis = {
          indexing = true,
          typeCheckingMode = "basic",
          diagnosticMode = "workspace",
          autoImportCompletions = true,
          autoSearchPaths = true,
          inlayHints = {
            variableTypes = true,
            functionReturnTypes = true,
          },
          useLibraryCodeForTypes = true,
          diagnosticSeverityOverrides = {
            reportGeneralTypeIssues = "none",
            reportOptionalMemberAccess = "none",
            reportOptionalSubscript = "none",
            reportPrivateImportUsage = "none",
            reportUnusedExpression = "none",
          },
        },
      },
    },
  }
end
local lua_ls_enabled = { enabled = false }
if table_contains(lsp_all, "lua_ls") then
  lua_ls_enabled = {
    -- Note: These settings will meaningfully increase the time until lua_ls
    -- can service initial requests (completion, location) upon starting as well
    -- as time to first diagnostics. Completion results will include a workspace
    -- indexing progress message until the server has finished indexing.
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = {
            "vim",
            "describe",
            "it",
            "before_each",
            "after_each",
            "pending",
            "nnoremap",
            "vnoremap",
            "inoremap",
            "tnoremap",
          },
        },
        workspace = {
          library = api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

local vimls_enabled = { enabled = false }
if table_contains(lsp_all, "vimls") then
  vimls_enabled = {
    flags = {
      debounce_text_changes = 500,
    },
  }
end

local tailwind_enabled = { enabled = false }
if table_contains(lsp_all, "tailwindcss") then
  tailwind_enabled = {
    capabilities = require("configs.lsp.servers.tailwindcss").capabilities,
    filetypes = require("configs.lsp.servers.tailwindcss").filetypes,
    init_options = require("configs.lsp.servers.tailwindcss").init_options,
    on_attach = require("configs.lsp.servers.tailwindcss").on_attach,
    settings = require("configs.lsp.servers.tailwindcss").settings,
  }
end

local cssls_enabled = { enabled = false }
if table_contains(lsp_all, "cssls") then
  cssls_enabled = {
    on_attach = require("configs.lsp.servers.cssls").on_attach,
    settings = require("configs.lsp.servers.cssls").settings,
  }
end

local vuels_enabled = { enabled = false }
if table_contains(lsp_all, "vuels") then
  vuels_enabled = {
    filetypes = require("configs.lsp.servers.vuels").filetypes,
    init_options = require("configs.lsp.servers.vuels").init_options,
    on_attach = require("configs.lsp.servers.vuels").on_attach,
    settings = require("configs.lsp.servers.vuels").settings,
  }
end

local eslint_enabled = { enabled = false }
if table_contains(lsp_all, "eslint") then
  eslint_enabled = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
      "svelte",
      "astro",
    },
    root_dir = require("lspconfig.util").root_pattern(".git"),
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine",
        },
        showDocumentation = {
          enable = true,
        },
      },
      codeActionOnSave = {
        enable = false,
        mode = "all",
      },
      experimental = {
        useFlatConfig = false,
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      packageManager = "npm",
      problems = {
        shortenToSingleLine = false,
      },
      quiet = false,
      rulesCustomizations = {},
      run = "onType",
      useESLintClass = false,
      validate = "on",
      workingDirectory = {
        mode = "location",
      },
    },
    on_attach = function(_, bufnr)
      api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  }
end

local tsserver_enabled = { enabled = false }
if table_contains(lsp_all, "tsserver") then
  -- make sure to only run this once!
  local formatter_bin = "eslint_d"
  if table_contains(formatters_linters, "prettier") then
    formatter_bin = "prettier"
  end
  local tsserver_on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls or conform
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup({
      enable_import_on_completion = true,
      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = false,
      eslint_opts = {},
      -- formatting
      enable_formatting = true,
      formatter = formatter_bin,
      formatter_opts = {},
      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    api.nvim_buf_set_keymap(bufnr, "n", ",go", ":TSLspOrganize<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", ",gR", ":TSLspRenameFile<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", ",gi", ":TSLspImportAll<CR>", opts)
  end

  tsserver_enabled = {
      on_attach = tsserver_on_attach,
      settings = require("configs.lsp.servers.tsserver").settings,
  }
end

local ccls_enabled = { enabled = false }
if table_contains(lsp_all, "ccls") then
  ccls_enabled = {
    init_options = {
      cache = {
        directory = ".ccls-cache",
      },
      highlight = {
        lsRanges = true,
      },
    },
  }
end
local clangd_enabled = { enabled = false }
if table_contains(lsp_all, "clangd") then
  clangd_enabled = {
    filetypes = { "c", "cpp", "cc", "mpp", "ixx", "objc", "objcpp", "cuda" },
    flags = {
      debounce_text_changes = 500,
      fallbackFlags = {
        "--query-driver=/**/*",
        "--clang-tidy",
        "--header-insertion=never",
        "--offset-encoding=utf-16",
      },
    },
    on_attach = function(client, bufnr)
      require("clangd_extensions.inlay_hints").setup_autocmd()
      require("clangd_extensions.inlay_hints").set_inlay_hints()
    end,
  }
end
local yamlls_enabled = { enabled = false }
if table_contains(lsp_all, "yamlls") then
  yamlls_enabled = {
    schemaStore = {
      enable = true,
      url = "https://www.schemastore.org/api/json/catalog.json",
    },
    schemas = {
      kubernetes = "*.yaml",
      ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
      ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
      ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
      ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
      ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
      ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
      ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
      ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
      ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
      ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
    },
    format = { enabled = false },
    validate = false,
    completion = true,
    hover = true,
  }
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = settings.enable_autoformat, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    capabilities = require "configs.lsp.capabilities",
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = disable_format,
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = lsp_installed,
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      bashls = bashls_enabled,
      ccls = ccls_enabled,
      clangd = clangd_enabled,
      cssls = cssls_enabled,
      eslint = eslint_enabled,
      lua_ls = lua_ls_enabled,
      pylsp = pylsp_enabled,
      pyright = pyright_enabled,
      tailwindcss = tailwind_enabled,
      tsserver = tsserver_enabled,
      vimls = vimls_enabled,
      vuels = vuels_enabled,
      yamlls = yamlls_enabled,
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler,
      -- function(server, opts) require("lspconfig")[server].setup(opts) end,

      -- functions take two parameters, the server name and the
      -- configured options table for that server
      -- the key is the server that is being setup with `lspconfig`

      -- setting a handler to false will disable the set up of that language server
      rust_analyzer = false,

      pyright = function(_, opts)
        if table_contains(lsp_all, "pyright") then
          require("lspconfig").pyright.setup(opts)
        end
      end,

      bashls = function(_, opts)
        if table_contains(lsp_all, "bashls") then
          require("lspconfig").bashls.setup(opts)
        end
      end,

      lua_ls = function(_, opts)
        if table_contains(lsp_all, "lua_ls") then
          require("lspconfig").lua_ls.setup(opts)
        end
      end,

      jsonls = function(_, opts)
        if table_contains(lsp_all, "jsonls") then
          require("lspconfig").jsonls.setup {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
              },
            },
          }
        end
      end,

      pylsp = function(_, opts)
        if table_contains(lsp_all, "pylsp") then
          require("lspconfig").pylsp.setup(opts)
        end
      end,

      vimls = function(_, opts)
        if table_contains(lsp_all, "vimls") then
          require("lspconfig").vimls.setup(opts)
        end
      end,

      yamlls = function(_, opts)
        if table_contains(lsp_all, "yamlls") then
          require("lspconfig").yamlls.setup(opts)
        end
      end,

      ccls = function(_, opts)
        if fn.executable "ccls" == 1 then
          require("lspconfig").ccls.setup(opts)
        end
      end,

      clangd = function(_, opts)
        if fn.executable "clangd" == 1 then
          require("lspconfig").clangd.setup(opts)
        end
      end,

      emmet_ls = function(_, opts)
        if table_contains(lsp_all, "emmet_ls") then
          require("lspconfig").emmet_ls.setup(opts)
        end
      end,

      graphql = function(_, opts)
        if table_contains(lsp_all, "graphql") then
          require("lspconfig").graphql.setup(opts)
        end
      end,

      html = function(_, opts)
        if table_contains(lsp_all, "html") then
          require("lspconfig").html.setup(opts)
        end
      end,

      prismals = function(_, opts)
        if table_contains(lsp_all, "prismals") then
          require("lspconfig").prismals.setup(opts)
        end
      end,
    },

    -- Configure `vim.lsp.handlers`
    lsp_handlers = require "configs.lsp.handlers",

    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- Can either be a string of a client capability
        -- or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever
        -- fails for all clients, the auto commands will be deleted for that buffer

        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,

        -- List of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function()
            vim.lsp.buf.clear_references()
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      -- map mode (:h map-modes)
      n = {
        -- a binding with no condition and therefore is always added
        gl = {
          function()
            vim.diagnostic.open_float()
          end,
          desc = "Hover diagnostics",
        },
        -- condition for only server with declaration capabilities
        gD = {
          function()
            vim.lsp.buf.declaration()
          end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        -- condition with a full function with `client` and `bufnr`
        ["<leader>uY"] = {
          function()
            require("astrolsp.toggles").buffer_semantic_tokens()
          end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client, bufnr)
            local prv_st = client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens
            return prv_st
          end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = require("configs.lsp.attach").on_attach,
  },
}
```

</details>
