-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options are configured in lua/options.lua
    options = require "options",
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs.
    -- For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        -- Telescope themes
        ["<Leader>T"] = { "<cmd>Telescope themes<CR>", desc = "Theme switcher" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
    autocmds = {
      -- autocommands are organized into augroups for easy management
      autohidetabline = {
        -- each augroup contains a list of auto commands
        {
          -- create a new autocmd on the "User" event
          event = "User",
          -- the pattern is the name of our User autocommand events
          pattern = "AstroBufsUpdated", -- triggered when vim.t.bufs is updated
          -- nice description
          desc = "Hide tabline when only one buffer and one tab",
          -- add the autocmd to the newly created augroup
          group = "autohidetabline",
          callback = function()
            -- if there is more than one buffer in the tab, show the tabline
            -- if there are 0 or 1 buffers in the tab, only show the tabline if there is more than one vim tab
            local new_showtabline = #vim.t.bufs > 1 and 2 or 1
            -- check if the new value is the same as the current value
            if new_showtabline ~= vim.opt.showtabline:get() then
              -- if it is different, then set the new `showtabline` value
              vim.opt.showtabline = new_showtabline
            end
          end,
        },
      },
      astronvimv4 = {
        {
          event = { "BufRead", "BufNewFile" },
          pattern = "*/node_modules/*",
          desc = "Disable diagnostics in node_modules",
          group = "astronvimv4",
          command = "lua vim.diagnostic.disable(0)",
        },
        {
          event = { "BufRead", "BufNewFile" },
          pattern = { "*.txt", "*.md", "*.tex" },
          desc = "Enable spell checking for certain file types",
          group = "astronvimv4",
          command = "setlocal spell",
        },
        {
          event = { "BufRead", "BufNewFile" },
          pattern = { "*.txt", "*.md", "*.json" },
          desc = "Show `` in specific files",
          group = "astronvimv4",
          command = "setlocal conceallevel=0",
        },
        {
          event = { "WinEnter", "BufWinEnter", "TermOpen" },
          desc = "Auto insert mode for Terminal",
          group = "astronvimv4",
          callback = function(args)
            if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
              vim.opt_local.wrap = true
              vim.opt_local.spell = false
              vim.cmd "startinsert"
            end
          end,
        },
        {
          event = { "TermOpen" },
          desc = "Disable line numbers and columns for Terminal",
          group = "astronvimv4",
          pattern = { "*" },
          callback = function()
            vim.opt_local["number"] = false
            vim.opt_local["signcolumn"] = "no"
            vim.opt_local["foldcolumn"] = "0"
          end,
        },
        {
          event = { "VimResized" },
          desc = "Resize splits if window got resized",
          group = "astronvimv4",
          callback = function() vim.cmd "tabdo wincmd =" end,
        },
        {
          event = { "UIEnter" },
          once = true,
          desc = "Get GUI config when entering UI",
          group = "astronvimv4",
          callback = function() require "ginit" end,
        },
      },
    },
  },
}
