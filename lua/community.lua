-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.
--
-- These community modules are conditional based on settings
-- in lua/configuration.lua and managed with Lazyman

local settings = require("configuration")
local enable_rust = {}
if settings.enable_community_rust then
  enable_rust = { import = "astrocommunity.pack.rust" }
end
local enable_markdown = {}
if settings.enable_community_markdown then
  enable_markdown = { import = "astrocommunity.pack.markdown" }
end
local enable_json = {}
if settings.enable_community_json then
  enable_json = { import = "astrocommunity.pack.json" }
end
local enable_yaml = {}
if settings.enable_community_yaml then
  enable_yaml = { import = "astrocommunity.pack.yaml" }
end
local enable_ps1 = {}
if settings.enable_community_ps1 then
  enable_ps1 = { import = "astrocommunity.pack.ps1" }
end
local enable_lua = {}
if settings.enable_community_lua then
  enable_lua = { import = "astrocommunity.pack.lua" }
end
local enable_python_ruff = {}
if settings.enable_community_python_ruff then
  enable_python_ruff = { import = "astrocommunity.pack.python-ruff" }
end
local enable_bash = {}
if settings.enable_community_bash then
  enable_bash = { import = "astrocommunity.pack.bash" }
end
local enable_html_css = {}
if settings.enable_community_html_css then
  enable_html_css = { import = "astrocommunity.pack.html-css" }
end
local enable_typescript = {}
if settings.enable_community_typescript then
  enable_typescript = { import = "astrocommunity.pack.typescript" }
end
local enable_angular = {}
if settings.enable_community_angular then
  enable_angular = { import = "astrocommunity.pack.angular" }
end
local enable_cpp = {}
if settings.enable_community_cpp then
  enable_cpp = { import = "astrocommunity.pack.cpp" }
end
local enable_cmake = {}
if settings.enable_community_cmake then
  enable_cmake = { import = "astrocommunity.pack.cmake" }
end

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  enable_rust,
  enable_markdown,
  enable_json,
  enable_yaml,
  enable_ps1,
  enable_lua,
  enable_python_ruff,
  enable_bash,
  enable_html_css,
  enable_typescript,
  enable_angular,
  enable_cpp,
  enable_cmake,
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.rose-pine" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    branch = "main",
    config = function()
      require("configs.themes.tokyonight")
    end,
  },
  { -- further customize the options set by the community
    "catppuccin",
    opts = {
      integrations = {
        sandwich = false,
        noice = false,
        mini = true,
        leap = true,
        markdown = true,
        neotest = true,
        cmp = true,
        overseer = true,
        lsp_trouble = true,
        rainbow_delimiters = true,
      },
    },
  },
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = 120,
      disabled_filetypes = { "help" },
    },
  },
  { import = "astrocommunity.completion.cmp-cmdline" },
  {
    "folke/twilight.nvim",
    cmd = {
      "Twilight",
      "TwilightEnable",
      "TwilightDisable",
    },
    keys = { { "<Leader>uT", "<CMD>Twilight<CR>", desc = "Toggle Twilight" } },
  },
  { import = "astrocommunity.editing-support.true-zen-nvim" },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.gitlinker-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
}
