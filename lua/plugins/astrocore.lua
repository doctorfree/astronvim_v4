-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

local settings = require("configuration")
local icons = require("icons")

require "keymaps"
require "options"

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
    options = {
      opt = {
        clipboard = "unnamed", --- Copy-paste between vim and everything else
        cmdheight = 0, --- Give more space for displaying messages
        completeopt = "menu,menuone,noselect", --- Better autocompletion
        cursorline = true, --- Highlight of current line
        emoji = false, --- Fix emoji display
        expandtab = true, --- Use spaces instead of tabs
        foldcolumn = "0",
        foldnestmax = 0,
        foldmethod = "expr",
        foldexpr = "nvim_treesitter#foldexpr()",
        foldlevel = 99, --- Using ufo provider need a large value
        foldlevelstart = 99, --- Expand all folds by default
        ignorecase = true, --- Needed for smartcase
        laststatus = 3, --- Global statusline at the bottom
        list = settings.list,
        listchars = settings.listchars,
        mouse = settings.mouse, --- Enable mouse
        number = settings.number, --- Shows current line number
        relativenumber = settings.relative_number, --- Enables relative number
        pumheight = 10, --- Max num of items in completion menu
        scrolloff = 8, --- Always keep space when scrolling to bottom/top edge
        shiftwidth = 2, --- Number of space characters inserted for indentation
        showtabline = settings.showtabline, --- Always show tabs
        spell = false, -- sets vim.opt.spell
        -- signcolumn  = "auto", -- sets vim.opt.signcolumn to auto
        signcolumn = "yes:2", --- Add extra sign column next to line number
        smartcase = true, --- Uses case in search
        smartindent = true, --- Makes indenting smart
        smarttab = true, --- Makes tabbing smarter will realize you have 2 vs 4
        softtabstop = 2, --- Insert 2 spaces for a tab
        splitright = true, --- Vertical splits will automatically be to the right
        swapfile = false, --- Swap not needed
        tabstop = 2, --- Insert 2 spaces for a tab
        termguicolors = true, --- Correct terminal colors
        timeoutlen = 300, --- Faster completion (cannot be lower than 200)
        ttimeoutlen = 0, --- Time to wait for a key code sequence to complete
        undofile = true, --- Sets undo to file
        updatetime = 100, --- Faster completion
        viminfo = "'1000", --- Increase the size of file history
        wildignore = "*node_modules/**", --- Don't search inside Node.js modules (works for gutentag)
        wrap = true, --- Display long lines as just one line
        writebackup = false, --- Not needed
        -- Neovim defaults
        autoindent = true, --- Good auto indent
        backspace = "indent,eol,start", --- Making sure backspace works
        backup = false, --- Recommended by coc
        -- Concealed text is completely hidden unless it has a custom replacement
        -- character defined (needed for dynamically showing tailwind classes)
        conceallevel = 2,
        concealcursor = "", --- Set to an empty string to expand tailwind class when on cursorline
        encoding = "utf-8", --- The encoding displayed
        errorbells = false, --- Disables sound effect for errors
        fileencoding = "utf-8", --- The encoding written to file
        incsearch = true, --- Start searching before pressing enter
        showmode = false, --- Don't show things like -- INSERT -- anymore
      },
      g = {
        speeddating_no_mappings = 1, --- Disable default mappings for speeddating
        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
        diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        camelcasemotion_key = "<leader>",
        loaded_perl_provider = 0,
        sonokai_style = "andromeda",
      },
    },
    -- Keymaps are spread all over Hell's halfacre in Neovim configurations.
    -- While I appreciate the effort to centralize them here, this work is not yet
    -- complete in this configuration. Mappings for this configuration are specified
    -- in lua/keymaps.lua, lua/configs/which-key.lua, and various plugin configurations.
    --
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs.
    -- For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- Tables with just a `desc` key will be registered with which-key if it's installed
        -- This is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        ["<Leader>T"] = {
          desc = icons.ui.Terminal .. "Terminal",
        },
        ["<Leader>t"] = {
          desc = icons.kinds.Color .. "Manage/Theme/Transparency",
        },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              require("astrocore.buffer").close(bufnr)
            end)
          end,
          desc = "Pick to close",
        },
        -- Quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        -- Telescope themes
        ["<Leader>tT"] = {
          "<cmd>Telescope themes<CR>",
          desc = "Telescope Theme Switcher",
        },
        ["<Leader>ta"] = {
          "<cmd>Alpha<CR>",
          desc = "Open Dashboard",
        },
        ["<Leader>tm"] = {
          "<cmd>Mason<CR>",
          desc = "Manage Packages",
        },
        ["<Leader>tp"] = {
          "<cmd>Lazy<CR>",
          desc = "Manage Plugins",
        },
        ["<Leader>tu"] = {
          "<cmd>Lazy update<CR>",
          desc = "Update Plugins",
        },

        ["<Leader>tc"] = {
          "<cmd>Telescope colorscheme<CR>",
          desc = "Telescope Color Schemes",
        },
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
            vim.opt_local["relativenumber"] = false
            vim.opt_local["signcolumn"] = "no"
            vim.opt_local["foldcolumn"] = "0"
            vim.opt_local["winhl"] = "Normal:NormalFloat"
          end,
        },
        {
          event = { "VimResized" },
          desc = "Resize splits if window got resized",
          group = "astronvimv4",
          callback = function()
            vim.cmd "tabdo wincmd ="
          end,
        },
        {
          event = { "UIEnter" },
          once = true,
          desc = "Get GUI config when entering UI",
          group = "astronvimv4",
          callback = function()
            require "ginit"
          end,
        },
      },
    },
  },
}
