# AstroNvim v4

**NOTE:** This is for AstroNvim v4+

A sample configuration for [AstroNvim](https://github.com/AstroNvim/AstroNvim) v4

## Table of Contents

- [Installation](#installation)
  - [Lazyman](#lazyman)
  - [Lazyman Screenshots](#lazyman-screenshots)
- [Features](#features)
- [Configuration](#configuration)
- [Usage](#usage)
  - [Keymaps](#keymaps)

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

<details><summary>Click here to view the AstroNvimV4

**Management with Lazyman screenshots**

</summary>

If `AstroNvimV4` was installed with `lazyman` an interactive menu system to
manage the `AstroNvimV4` configuration is available in `lazyman`. To view
the main `AstroNvimV4` configuration menu invoke `lazyman -F anv` or simply
`lazyman` and select the `AstroNvimV4 Config` menu entry:

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/lazyman.png" style="width:1165px;height:588px;">
</p>
</div>

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

<details><summary>Click here to view the

**AstroNvimV4 Keymaps screenshots**

</summary>

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/Keymaps.png" style="width:806px;height:483px;">
</p>
</div>

Command and Themes keymaps (view with `<leader>,`

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/Command_Keymaps.png" style="width:806px;height:483px;">
</p>
</div>

Toggle keymaps (view with `<leader>.`

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/Toggle_Keymaps.png" style="width:806px;height:483px;">
</p>
</div>

UI/UX and more toggle keymaps (view with `<leader>u`

<div align="center"><p>
<img src="https://raw.githubusercontent.com/wiki/doctorfree/astronvim_v4/screenshots/UI.png" style="width:1780px;height:720px;">
</p>
</div>

</details>
