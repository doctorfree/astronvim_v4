local settings = require("configuration")
local prefix = "<Leader>T"
local neotest = {}
if settings.enable_neotest then
  neotest = {
    "nvim-neotest/neotest",
    lazy = true,
    optional = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              [prefix] = { desc = "󰗇 Tests" },
              [prefix .. "t"] = { function() require("neotest").run.run() end, desc = "Run test" },
              [prefix .. "d"] = { function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug test" },
              [prefix .. "f"] = {
                function() require("neotest").run.run(vim.fn.expand "%") end,
                desc = "Run all tests in file",
              },
              [prefix .. "p"] = {
                function() require("neotest").run.run(vim.fn.getcwd()) end,
                desc = "Run all tests in project",
              },
              [prefix .. "<CR>"] = { function() require("neotest").summary.toggle() end, desc = "Test Summary" },
              [prefix .. "o"] = { function() require("neotest").output.open() end, desc = "Output hover" },
              [prefix .. "O"] = { function() require("neotest").output_panel.toggle() end, desc = "Output window" },
              ["]T"] = { function() require("neotest").jump.next() end, desc = "Next test" },
              ["[T"] = { function() require("neotest").jump.prev() end, desc = "previous test" },
            },
          },
        },
      },
      {
        "folke/neodev.nvim",
        dependencies = {
          "hrsh7th/nvim-cmp",
        },
        opts = function(_, opts)
          opts.library = {
            plugins = { "nvim-dap-ui", "neotest" },
            types = true
          }
          opts.setup_jsonls = true
          opts.lspconfig = true
          opts.pathStrict = true
          opts.override = function(root_dir, library)
            local util = require "neodev.util"
            if util.has_file(root_dir, "/etc/nixos") or util.has_file(root_dir, "nvim-config") then
              library.enabled = true
              library.plugins = true
            end
          end
        end,
      },
    },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-python"(require("astrocore").plugin_opts "neotest-python"))
    end,
    config = function(_, opts)
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, vim.api.nvim_create_namespace "neotest")
      require("neotest").setup(opts)
    end,
  }
end

---@type LazySpec
return neotest
