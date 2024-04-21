local settings = require("configuration")
local toggleterm = { "akinsho/nvim-toggleterm.lua", enabled = false }
if settings.enable_toggleterm then
  toggleterm = {
    "akinsho/nvim-toggleterm.lua",
    lazy = false,
    branch = "main",
    dependencies = {
      "sunjon/shade.nvim",
      config = function()
        require'shade'.setup({
          overlay_opacity = 50,
          opacity_step = 1,
          keys = {
            brightness_up    = '<C-Up>',
            brightness_down  = '<C-Down>',
            toggle           = '<Leader>s',
          }
        })
      end
    },
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
      "Astroconf",
      "Astrolsp",
      "Astroform",
      "Astroplug",
      "Top",
    },
    event = "VimEnter",
    config = function()
      require("configs.terminal_nvim")
    end,
  },
  toggleterm,
}
