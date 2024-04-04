# Changelog

## Unreleased

### ⚡️ Added

### 🐞 Fixed

## v1.0.1r3

### ⚡️ Added

- Expand and configure notes plugins with `Neorg` custom configuration
- Add `Neorg` setting in `configuration.lua`
- Expand `lua/options.lua`
- Use `configuration.lua` settings in `Mason` installs
- Expand `conform` configuration
- Add linter configurations in `.linter_configs`
- Add formatters and linters to `configuration.lua`

### 🐞 Fixed

- Fix `Neorg` build using `Luarocks`
- Fix options return tables

## v1.0.1r2

### ⚡️ Added

- Add some `treesitter` parsers to `ensure_installed`
- Add `cmp-cmdline` command line completion plugin
- Use `configuration.lua` setting for treesitter `ensure_installed`
- Add `configuration.lua` and `options.lua`
- Add support for more colorschemes

### 🐞 Fixed

- Remove `git` plugins from `Alpha` dashboard
- Fix options and config `Alpha` buttons

## v1.0.1r1

### ⚡️ Added

- Customize `alpha.nvim` dashboard
- Customize `telescope`
- Customize `autopairs`
- Expand `neotest` and `nvim-dap` configs
- Add support for `Neogit`
- Install alternate colorschemes
- Set `tokyonight` as default colorscheme
- Add colorscheme configurations in `lua/configs/themes`

### 🐞 Fixed

- Revert to template autopairs
- Silence `dapui` toggle
- Adopt `dap` configuration from `Ecovim`

## v1.0.0r1

### ⚡️ Added

- Created initial `AstroNvim` v4 configuration from template
- Customize status line, UI, themes, colorscheme, treesitter parsers, LSP, formatters, ...
- Add release and version control

### 🐞 Fixed

- First shot at DAP UI fixes
