local settings = require("configuration")
local util = require("utils")

---@type LazySpec
return {
  "rebelot/terminal.nvim",
  cmd = {
    "Asciiville",
    "MusicPlayerPlus",
    "MusicPlayerMenu",
    "TermOpen",
    "TermToggle",
    "TermRun",
    "Lazygit",
    "IPython",
    "Lazyman",
    "Lazyconf",
    "Lazyplug",
    "Htop",
  },
  event = "VimEnter",
  config = function()
    require("configs.terminal_nvim")
  end,
}
