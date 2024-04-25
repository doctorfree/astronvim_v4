# Changelog

## Unreleased

### ⚡️ Added

### 🐞 Fixed

## v1.0.6r2

### ⚡️ Added

- Add community modules enable/disable to `configuration.lua`
- Style `Mason` UI
- Add `gitignore` file
- Add `cmp_luasnip`
- Add `snippets`, `friendly-snippets`, load snippets

### 🐞 Fixed

- Disable all community language modules by default
- Rework LSP `capabilities`

## v1.0.6r1

### ⚡️ Added

- Integrate `AstroNvim` v4 `toggleterm` config
- Additional `astrocommunity` packs, `vscode` support
- Community plugins conditional in `configuration.lua`
- Make `treesitter-context` conditional and disabled by default in `configuration.lua`
- Add check for `show_diagnostics` setting in `on_attach`
- Enable conditional diagnostic popup with setting in `configuration.lua`

### 🐞 Fixed

- Fix syntax of `open_float` in `astrolsp.lua`
- Remove temporary `astrolsp.lua` from scripts
- Replace `setup` with `config` key in `scissors` plugin spec
- Do not disable `nvim-notify` in `community.lua`, `Noice` needs it

## v1.0.5r4

### ⚡️ Added

- Migrate some functions from `Lazyman free` namespace to `utils/init.lua`
- Expose main `Lazyman` menu screenshot in `README`
- Add `Cheatsheet` screenshot to `README`
- Add screenshot to top of `README`
- Add `Git` menu screenshot to `README`

### 🐞 Fixed

- Fix calls to `toggle()` function in `lua/utils/init.lua`

## v1.0.5r3

### ⚡️ Added

- Add `Update` and `Remove` sections to `README`
- Add `astrocore.lua` listing to `README`
- Add UI Keymaps screenshot to `README`
- Add Keymaps screenshots to `README`
- Add interactive menu screenshots to `README`

### 🐞 Fixed

- Reorder sections in `README`

## v1.0.5r2

### ⚡️ Added

- Add icons to names for all `which-key` folders
- Add UI borders for `Lazy` and `Mason`

### 🐞 Fixed

- Fix `Mason` and `Terminal` dependencies and setup

## v1.0.5r1

### ⚡️ Added

- Integrate all LSP servers and formatters into `astrolsp`
- Override `nvim-lspconfig` configuration setup
- Add notifications enable to `lazy` setup
- Add `enable_autoformat` to `configuration.lua` to make auto formatting conditional

### 🐞 Fixed

- Remove `navic`
- Fix `shfmt` and `shellcheck` conditional formatting with `configuration.lua`

## v1.0.4r3

### ⚡️ Added

- Additional `cheatsheet` improvements and mappings in `astrocore.lua`
- Port `cheatsheet.txt` to `AstroNvimV4`
- Add autocmds and mappings for `AstroNvimV4` configuration submenus
- Add mappings for `cheatsheet` and command line submenus
- Add `cheatsheet` and smooth scrolling plugins

### 🐞 Fixed

- Add `cheatsheet` to `Features` in readme and release notes

## v1.0.4r2

### ⚡️ Added

- Integration with `lazyman` interactive menu system
- Add comments used by `Lazyman` to `LSP` and `Formatters` tables in `configuration.lua`
- Add `configuration.lua` conditional support for `neotest` and `toggleterm` plugins
- Add `wakatime` plugin optionally enabled in `configuration.lua`
- Add `shfmt` usage in comments, add `-sr` to `shfmt` arguments
- Add `none-ls` configuration, add nerd icons and set them in `heirline`

### 🐞 Fixed

- Continue to move keymaps from `keymaps.lua` to `astrocore.lua`
- Add custom `tabline`, `winbar`, `statusline` to readme and release notes features section

- Fix shellcheck config in none-ls
- Fix none-ls setup

## v1.0.4r1

### ⚡️ Added

- Configure `heirline` `tabline` and `winbar`
- Add transparency toggles
- Add toggle transparency function for `Catppuccin`, `Everforest`, and `Kanagawa`
- Move user autocmds to `astrocore.lua` `commands` section

### 🐞 Fixed

- Remove `onedarkpro`
- Fix setup and loading of `monokai-pro` colorscheme

## v1.0.3r4

### ⚡️ Added

- Move terminal command mappings from `keymaps.lua` to `astrocore.lua`
- Move `AstroNvimV4` custom mappings to `<Leader>,` and terminal to `<Leader>t`
- Move mappings from `keymaps.lua` to `astrocore.lua`
- Add custom `toggleterm`, conditional on setting in `configuration.lua`
- Move terminal `which-key` mappings to `<leader>T`
- Add `<Leader>t` which-key group in `astrocore.lua`
- Add support for `clangd`
- Add more `treesitter` parsers to `ensure_installed`
- Add temporary `astrolsp.lua` for initialization

### 🐞 Fixed

- Fix `desc` format in mappings in `astrocore.lua`
- Fix Terminal `which-key` group mappings
- Cleanup which-key names and mappings

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
