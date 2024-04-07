local settings = require("configuration")

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "hiphish/rainbow-delimiters.nvim",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-textsubjects",
  },
  opts = function(_, opts)
    opts.ensure_installed =
      require("astrocore").list_insert_unique(opts.ensure_installed, settings.treesitter_ensure_installed)
    opts.auto_install = true
    opts.sync_install = false

    opts.ignore_install = {}
    opts.highlight = {
      enable = true,
      -- disable = { "c", "rust" },  -- list of language that will be disabled
      -- additional_vim_regex_highlighting = false,
    }

    opts.incremental_selection = {
      enable = false,
      keymaps = {
        init_selection    = "<leader>gnn",
        node_incremental  = "<leader>gnr",
        scope_incremental = "<leader>gne",
        node_decremental  = "<leader>gnt",
      },
    }

    opts.indent = {
      enable = true
    }

    opts.context_commentstring = {
      enable = false,
      enable_autocmd = false,
    }

    opts.textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]]"] = "@function.outer",
          ["]m"] = "@class.outer",
        },
        goto_next_end = {
          ["]["] = "@function.outer",
          ["]M"] = "@class.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
          ["[m"] = "@class.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
          ["[M"] = "@class.outer",
        },
      },
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["~"] = "@parameter.inner",
        },
      },
    }

    opts.textsubjects = {
      enable = true,
      keymaps = {
        ['<cr>'] = 'textsubjects-smart', -- works in visual mode
      }
    }
  end,
}
