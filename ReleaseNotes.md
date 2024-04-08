# AstroNvimV4 Release Notes

**NOTE:** This configuration is for AstroNvim v4+

A sample configuration for [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

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
