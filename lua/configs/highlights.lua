local present, tokyonight = pcall(require, "tokyonight")
if not present then
  return
end

local c = require("tokyonight.colors").setup()

-- Set Colorscheme
-- vim.cmd("colorscheme " .. AstroNvimV4.colorscheme)

-- AstroNvimV4 Colors
vim.api.nvim_set_hl(0, "AstroNvimV4Primary", { fg = "#488dff" })
vim.api.nvim_set_hl(0, "AstroNvimV4Secondary", { fg = "#FFA630" })

vim.api.nvim_set_hl(0, "AstroNvimV4PrimaryBold", { bold = true, fg = "#488DFF" })
vim.api.nvim_set_hl(0, "AstroNvimV4SecondaryBold", { bold = true, fg = "#FFA630" })

vim.api.nvim_set_hl(0, "AstroNvimV4Header", { bold = true, fg = "#488DFF" })
vim.api.nvim_set_hl(0, "AstroNvimV4HeaderInfo", { bold = true, fg = "#FFA630" })
vim.api.nvim_set_hl(0, "AstroNvimV4Footer", { bold = true, fg = "#FFA630" })

vim.api.nvim_set_hl(0, "AstroNvimV4NvimTreeTitle", { bold = true, fg = "#FFA630", bg = "#16161e" })

-- Tokyonight Colorscheme Specific Config
-- Lines
vim.api.nvim_set_hl(0, "CursorLineNR", { link = "AstroNvimV4Secondary" })
vim.api.nvim_set_hl(0, "LineNr", { link = "Comment" })

-- Floats/Windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None", fg = "None" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "None", fg = "#488DFF" })
vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "None", fg = "#488DFF" })
vim.api.nvim_set_hl(0, "BufferTabpageFill", { fg = "None" })
vim.api.nvim_set_hl(0, "VertSplit", { bg = "#16161e", fg = "#16161e" })
vim.api.nvim_set_hl(0, "BqfPreviewBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "BufferInactiveIndex", { link = "BufferInactive" })
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

-- Tree
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { bg = "None", fg = "None" })

-- Misc
vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "None" })
vim.api.nvim_set_hl(0, "rainbowcol1", { fg = c.blue, ctermfg = 9 })
vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = c.blue, ctermfg = 9 })
vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = c.blue, ctermfg = 9 })
vim.api.nvim_set_hl(0, "Boolean", { fg = "#F7768E" })
vim.api.nvim_set_hl(0, "BufferOffset", { link = "AstroNvimV4Secondary" })
vim.api.nvim_set_hl(0, "LspInlayHint", { link = "LspCodeLens" })

-- Bufferline
vim.api.nvim_set_hl(0, "BufferCurrentSign", { fg = c.cyan })
vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "#202331", fg = c.dark3 })
vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = "NONE", fg = c.yellow })

vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { bg = "#16161e", fg = "#16161e" })

-- Completion Menu Colors
local highlights = {
  CmpItemAbbr = { fg = c.dark3, bg = "NONE" },
  CmpItemKindClass = { fg = c.orange },
  CmpItemKindConstructor = { fg = c.purple },
  CmpItemKindFolder = { fg = c.blue2 },
  CmpItemKindFunction = { fg = c.blue },
  CmpItemKindInterface = { fg = c.teal, bg = "NONE" },
  CmpItemKindKeyword = { fg = c.magenta2 },
  CmpItemKindMethod = { fg = c.red },
  CmpItemKindReference = { fg = c.red1 },
  CmpItemKindSnippet = { fg = c.dark3 },
  CmpItemKindVariable = { fg = c.cyan, bg = "NONE" },
  CmpItemKindText = { fg = "LightGrey" },
  CmpItemMenu = { fg = "#C586C0", bg = "NONE" },
  CmpItemAbbrMatch = { fg = "#569CD6", bg = "NONE" },
  CmpItemAbbrMatchFuzzy = { fg = "#569CD6", bg = "NONE" },
}

vim.api.nvim_set_hl(0, "CmpBorderedWindow_FloatBorder", { fg = c.blue0 })

for group, hl in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, hl)
end
