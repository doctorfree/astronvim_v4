# Changelog

## Unreleased

### ⚡️ Added

### 🐞 Fixed

## v1.0.3r3

### ⚡️ Added

- Customize `marksman.toml`, `stylua.toml`, and `selene.toml`

### 🐞 Fixed

- Remove `conform` and linter configs

## v1.0.3r2

### ⚡️ Added

- Add `zen-mode` plugin and settings for it in `configuration.lua`
- Add `package-info`, `markdown-preview`, and telescope `repo` extension
- Add `keymaps` and customize `which-key`, integrate `options` into `astrocore`
- Add `which-key` menu entry for `Terminal`
- Add `terminal` plugin with autocmds/commands for `lazygit`, `lazyman`, `htop`, etc

### 🐞 Fixed

- Update `stylua` toml with less aggressive settings

## v1.0.3r1

### ⚡️ Added

- Refactor LSP configuration using `AstroNvim` v4 `astrolsp`
- Add `pyenv` home to `python` path search in `options.lua`
- Conditional formatting settings based on `configuration.lua`
- Configure `neodev` and `dap-ui`
- Add autocmds for resizing and entering gui
- Finish porting `yamlls` and `ccls` lsp configs to `astrolsp`
- Move `yamlls` and `ccls` lsp config to `astrolsp`
- Add example autocmds in `astrocore`
- Configure `pyright` in `astrolsp`
- Enable `LuaSnip`
- Define `heirline` ruler to show line number and column
- Concatenate lsp server tables in `lspconfig.lua` and `astrolsp.lua`
- Move `jsonls` out of installed lsp servers
- Move `vimls` in, `taplo` out of `navic` and into `mason-lspconfig`
- Update readme `configuration.lua`
- Adjust treesitter `ensure_installed`

### 🐞 Fixed

- Comment out formatters not yet working
- Replace `null-ls` with `none-ls`
- Reduce number of preinstalled treesitter parsers
- Cleanup unused functions/vars

## v1.0.2r2

### ⚡️ Added

- Integrate LSP handlers/servers into `astrolsp`
- Move LSP handlers and configuration to `astrolsp`
- Move capabilities/handlers/on_attach to `lua/configs/lsp`
- Add test scripts and `lazyman` install script

### 🐞 Fixed

- Remove unused lsp configs
- Use options.lua in `Alpha` dashboard for `Options` button

## v1.0.2r1

### ⚡️ Added

- Add `navic` support
- Integrate `lspconfig` from `Lazyman` with `AstroNvim`
  - `Lazyman` LSP handlers not yet integrated into `astrolsp`
- Add example mapping in `astrocore` for `Telescope` themes
- Add note about leader key in readme
- Add Features section to readme
- Add Configuration section to readme

### 🐞 Fixed

- Revert changes to `astrolsp`

## v1.0.1r4

### ⚡️ Added

- Add support for `Obsidian` plugin to notes

### 🐞 Fixed

- Remove `Neorg` from notes plugins

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
