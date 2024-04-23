local settings = require("configuration")
local toggleterm = { "akinsho/toggleterm.nvim", enabled = false }
if settings.enable_toggleterm then
  toggleterm = {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local astro = require "astrocore"
          maps.n["<Leader>t"] = vim.tbl_get(opts, "_map_sections", "t")
          if vim.fn.executable "lazygit" == 1 then
            maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
            maps.n["<Leader>gg"] = {
              function()
                local worktree = astro.file_worktree()
                local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
                  or ""
                astro.toggle_term_cmd("lazygit " .. flags)
              end,
              desc = "ToggleTerm lazygit",
            }
            maps.n["<Leader>tl"] = maps.n["<Leader>gg"]
          end
          if vim.fn.executable "node" == 1 then
            maps.n["<Leader>tn"] = { function() astro.toggle_term_cmd "node" end, desc = "ToggleTerm node" }
          end
          local gdu = vim.fn.has "mac" == 1 and "gdu-go" or "gdu"
          if vim.fn.executable(gdu) == 1 then
            maps.n["<Leader>tu"] = { function() astro.toggle_term_cmd(gdu) end, desc = "ToggleTerm gdu" }
          end
          if vim.fn.executable "btm" == 1 then
            maps.n["<Leader>tt"] = { function() astro.toggle_term_cmd "btm" end, desc = "ToggleTerm btm" }
          end
          local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
          if python then
            maps.n["<Leader>tp"] = { function() astro.toggle_term_cmd(python) end, desc = "ToggleTerm python" }
          end
          maps.n["<Leader>tf"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
          maps.n["<Leader>th"] =
            { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" }
          maps.n["<Leader>tv"] = { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }
          maps.n["<F7>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" }
          maps.t["<F7>"] = { "<Cmd>ToggleTerm<CR>", desc = maps.n["<F7>"].desc }
          maps.i["<F7>"] = { "<Esc>" .. maps.t["<F7>"][1], desc = maps.n["<F7>"].desc }
          maps.n["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
          maps.t["<C-'>"] = maps.t["<F7>"] -- requires terminal that supports binding <C-'>
          maps.i["<C-'>"] = maps.i["<F7>"] -- requires terminal that supports binding <C-'>
        end,
      },
    },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<F12>]],
      ---@param t Terminal
      on_create = function(t)
        vim.opt_local.foldcolumn = "0"
        vim.opt_local.signcolumn = "no"
        if t.hidden then
          local toggle = function() t:toggle() end
          vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
          vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
        end
      end,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true,
      direction = "float", -- | 'vertical' | 'horizontal' | 'tab' | 'float',
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      -- float_opts = { border = "rounded" },
      float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved', -- single/double/shadow/curved
        width = math.floor(0.7 * vim.fn.winwidth(0)),
        height = math.floor(0.8 * vim.fn.winheight(0)),
        winblend = 4,
      },
      winbar = {
        enabled = true,
      },
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
