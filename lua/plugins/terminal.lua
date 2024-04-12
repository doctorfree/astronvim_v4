local settings = require("configuration")
local toggleterm = { "akinsho/nvim-toggleterm.lua", enabled = false }
if settings.enable_toggleterm then
  toggleterm = {
    "akinsho/nvim-toggleterm.lua",
    lazy = false,
    branch = "main",
    config = function()
      require("configs.toggleterm")
    end,
    keys = {
      { "<Leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal Float" },
    },
  }
end

---@type LazySpec
return {
  {
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
      "Top",
    },
    event = "VimEnter",
    config = function()
      require("configs.terminal_nvim")
    end,
  },
  toggleterm,
}
