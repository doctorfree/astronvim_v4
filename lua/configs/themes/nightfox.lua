local settings = require "configuration"

local load_colorscheme = function(scheme_style)
  if scheme_style == "carbonfox" then
    vim.cmd [[colorscheme carbonfox]]
  elseif scheme_style == "dayfox" then
    vim.cmd [[colorscheme dayfox]]
  elseif scheme_style == "dawnfox" then
    vim.cmd [[colorscheme dawnfox]]
  elseif scheme_style == "duskfox" then
    vim.cmd [[colorscheme duskfox]]
  elseif scheme_style == "nordfox" then
    vim.cmd [[colorscheme nordfox]]
  elseif scheme_style == "terafox" then
    vim.cmd [[colorscheme terafox]]
  else
    vim.cmd [[colorscheme nightfox]]
  end
end

local function set_colorscheme(sty)
  local have_current = false
  local theme_ok, _ = pcall(require, "current-theme")
  if theme_ok then
    have_current = true
  end
  if have_current then
    require "current-theme"
  else
    load_colorscheme(sty)
  end
end

local nightfox_options = {
  -- Compiled file's destination location
  compile_path = vim.fn.stdpath("cache") .. "/nightfox",
  compile_file_suffix = "_compiled", -- Compiled file suffix
  transparent = settings.enable_transparent,
  terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
  dim_inactive = false, -- Non focused panes set to alternative background
  module_default = true, -- Default enable value for modules
  colorblind = {
    enable = false, -- Enable colorblind support
    simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
    severity = {
      protan = 0, -- Severity [0,1] for protan (red)
      deutan = 0, -- Severity [0,1] for deutan (green)
      tritan = 0, -- Severity [0,1] for tritan (blue)
    },
  },
  styles = { -- Style to be applied to different syntax groups
    comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
    conditionals = "NONE",
    constants = "NONE",
    functions = "NONE",
    keywords = "NONE",
    numbers = "NONE",
    operators = "NONE",
    strings = "NONE",
    types = "NONE",
    variables = "NONE",
  },
  inverse = { -- Inverse highlight for different types
    match_paren = false,
    visual = false,
    search = false,
  },
}

-- Default options
require("nightfox").setup {
  options = nightfox_options,
  -- palettes = {},
  -- specs = {},
  -- groups = {},
}

-- setup must be called before loading
if settings.theme == "nightfox" then
  local style = settings.theme_style
  set_colorscheme(style)
  local toggle_transparency = function()
    nightfox_options.transparent = not nightfox_options.transparent
    require("nightfox").setup {
      options = nightfox_options,
      -- palettes = {},
      -- specs = {},
      -- groups = {},
    }
    set_colorscheme(style)
    load_colorscheme(style)
  end
  require("utils").map("n", "<leader>,t", toggle_transparency, { desc = "Toggle Transparency" })
  require("utils").map("n", "<leader>.t", toggle_transparency, { desc = "Toggle Transparency" })
  vim.api.nvim_set_hl(0, "AlphaHeader", { link = "DashboardHeader" })
  vim.api.nvim_set_hl(0, "AlphaHeaderLabel", { link = "DashboardHeader" })
  vim.api.nvim_set_hl(0, "AlphaButtons", { link = "DashboardCenter" })
  vim.api.nvim_set_hl(0, "AlphaShortcut", { link = "DashboardShortcut" })
  vim.api.nvim_set_hl(0, "AlphaFooter", { link = "DashboardFooter" })
  require "configs.highlights"
end
