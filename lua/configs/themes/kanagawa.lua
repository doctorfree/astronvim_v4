local settings = require "configuration"

local all_config = {}
if settings.enable_transparent then all_config = {
  ui = {
    bg_gutter = "none",
  },
} end

local function set_colorscheme(sty)
  local have_current = false
  local theme_ok, _ = pcall(require, "current-theme")
  if theme_ok then have_current = true end
  if have_current then
    require "current-theme"
  else
    if sty == "wave" then
      vim.cmd [[colorscheme kanagawa-wave]]
    elseif sty == "dragon" then
      vim.cmd [[colorscheme kanagawa-dragon]]
    elseif sty == "lotus" then
      vim.cmd [[colorscheme kanagawa-lotus]]
    else
      vim.cmd [[colorscheme kanagawa]]
    end
  end
end

-- Default options:
require("kanagawa").setup {
  compile = false, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = settings.enable_transparent,
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = { -- add/modify theme and palette colors
    palette = {},
    theme = {
      wave = {},
      lotus = {},
      dragon = {},
      all = all_config,
    },
  },
  overrides = function(colors) -- add/modify highlights
    return {}
  end,
  theme = "wave", -- Load "wave" theme when 'background' option is not set
  background = { -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus",
  },
}

if settings.theme == "kanagawa" then
  local style = settings.theme_style
  set_colorscheme(style)
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { link = "DashboardIcon" })
  vim.api.nvim_set_hl(0, "NeoTreeRootName", { link = "NvimTreeRootFolder" })
  vim.api.nvim_set_hl(0, "NeoTreeFileName", { link = "NvimTreeExecFile" })
  vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { link = "DashboardIcon" })
  vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { link = "NvimTreeOpenedFile" })
  vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { link = "NvimTreeIndentMarker" })
  vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { link = "NvimTreeGitNew" })
  vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { link = "NvimTreeGitDirty" })
  vim.api.nvim_set_hl(0, "NeoTreeGitModified", { link = "NvimTreeGitStaged" })
  vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "NvimTreeGitDeleted" })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "NvimTreeNormal" })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "NvimTreeNormalNC" })
  vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { link = "NvimTreeSymlink" })
  vim.api.nvim_set_hl(0, "AlphaHeader", { link = "NvimTreeGitStaged" })
  vim.api.nvim_set_hl(0, "AlphaHeaderLabel", { link = "NvimTreeGitStaged" })
  vim.api.nvim_set_hl(0, "AlphaButtons", { link = "NvimTreeImageFile" })
  vim.api.nvim_set_hl(0, "AlphaShortcut", { link = "NvimTreeSymlink" })
  vim.api.nvim_set_hl(0, "AlphaFooter", { link = "NvimTreeSpecialFile" })
  require "configs.highlights"
end
