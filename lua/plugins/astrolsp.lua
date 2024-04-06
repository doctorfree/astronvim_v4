-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local settings = require("configuration")
local lsp_servers = settings.lsp_servers
local lsp_installed = settings.lsp_installed
local lsp_all = require("utils").concat_tables(lsp_servers, lsp_installed)
local formatters_linters = settings.formatters_linters
local external_formatters = settings.external_formatters
local table_contains = require("utils").table_contains
local fn = vim.fn
local api = vim.api

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = lsp_installed,
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      function(server, opts) require("lspconfig")[server].setup(opts) end,

      -- the key is the server that is being setup with `lspconfig`
      rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end,
      bashls = function(_, opts)
        if table_contains(lsp_all, "bashls") then
          -- Enable/Disable shellcheck in bashls
          local bashls_settings = {
            bashIde = {
              backgroundAnalysisMaxFiles = 500,
              enableSourceErrorDiagnostics = false,
              explainshellEndpoint = "",
              globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
              includeAllWorkspaceSymbols = false,
              logLevel = "info",
              shellcheckArguments = "",
              shellcheckPath = vim.env.SHELLCHECK_PATH or "",
            },
          }
          if table_contains(formatters_linters, "shellcheck") then
            bashls_settings = {
              bashIde = {
                backgroundAnalysisMaxFiles = 500,
                enableSourceErrorDiagnostics = false,
                explainshellEndpoint = "",
                globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
                includeAllWorkspaceSymbols = false,
                logLevel = "info",
                shellcheckArguments = "",
                shellcheckPath = vim.env.SHELLCHECK_PATH or "shellcheck",
              },
            }
          end
          require("lspconfig").bashls.setup({ settings = bashls_settings })
        end
      end,

      lua_ls = function(_, opts)
        if table_contains(lsp_all, "lua_ls") then
          require("lspconfig").lua_ls.setup({
            capabilities = require("configs.lsp.capabilities"),
            require("neodev").setup({
              library = { plugins = { "nvim-dap-ui" }, types = true },
              setup_jsonls = true,
              lspconfig = false,
              pathStrict = true,
              override = function(root_dir, library)
                local util = require("neodev.util")
                if util.has_file(root_dir, "/etc/nixos") or util.has_file(root_dir, "nvim-config") then
                  library.enabled = true
                  library.plugins = true
                end
              end,
            }),
            -- Note: These settings will meaningfully increase the time until lua_ls
            -- can service initial requests (completion, location) upon starting as well
            -- as time to first diagnostics. Completion results will include a workspace
            -- indexing progress message until the server has finished indexing.
            before_init = require("neodev.lsp").before_init,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = {
                    "vim",
                    "describe",
                    "it",
                    "before_each",
                    "after_each",
                    "pending",
                    "nnoremap",
                    "vnoremap",
                    "inoremap",
                    "tnoremap",
                  },
                },
                workspace = {
                  library = api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          })
        end
      end,

      jsonls = function(_, opts)
        if table_contains(lsp_all, "jsonls") then
          require("lspconfig").jsonls.setup({
            capabilities = require("configs.lsp.capabilities"),
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
              },
            },
          })
        end
      end,

      pylsp = function(_, opts)
        if table_contains(lsp_all, "pylsp") then
          local venv_path = os.getenv('VIRTUAL_ENV')
          local py_path = nil
          -- decide which python executable to use for mypy
          if venv_path ~= nil then
            py_path = venv_path .. "/bin/python3"
          else
            py_path = vim.g.python3_host_prog
          end
          local enable_black = { enabled = false }
          if table_contains(external_formatters, "black") then
            enable_black = { enabled = true }
          end
          local enable_ruff = { enabled = false }
          if table_contains(external_formatters, "ruff") then
            enable_ruff = { enabled = true }
          end
          require("lspconfig").pylsp.setup({
            capabilities = require("configs.lsp.capabilities"),
            settings = {
              pylsp = {
                plugins = {
                  -- formatter options
                  black = enable_black,
                  autopep8 = { enabled = false },
                  yapf = { enabled = false },
                  -- linter options
                  pylint = { enabled = false },
                  ruff = enable_ruff,
                  pyflakes = { enabled = false },
                  pycodestyle = { enabled = false },
                  -- type checker
                  pylsp_mypy = {
                    enabled = true,
                    overrides = { "--python-executable", py_path, true },
                    report_progress = true,
                    live_mode = false
                  },
                  -- auto-completion options
                  jedi_completion = { fuzzy = true },
                  -- import sorting
                  isort = { enabled = true },
                },
              },
            },
            flags = {
              debounce_text_changes = 200,
            },
          })
        end
      end,

      vimls = function(_, opts)
        if table_contains(lsp_all, "vimls") then
          require("lspconfig").vimls.setup {
            flags = {
              debounce_text_changes = 500,
            },
            capabilities = require("configs.lsp.capabilities"),
          }
        end
      end,

      clangd = function(_, opts)
        if fn.executable("clangd") == 1 then
          require("lspconfig").clangd.setup({
            capabilities = require("configs.lsp.capabilities"),
            filetypes = { "c", "cpp", "cc" },
            flags = {
              debounce_text_changes = 500,
            },
          })
        end
      end,

      emmet_ls = function(_, opts)
        if table_contains(lsp_all, "emmet_ls") then
          require("lspconfig").emmet_ls.setup({
            capabilities = require("configs.lsp.capabilities"),
          })
        end
      end,

      graphql = function(_, opts)
        if table_contains(lsp_all, "graphql") then
          require("lspconfig").graphql.setup({
            capabilities = require("configs.lsp.capabilities"),
          })
        end
      end,

      html = function(_, opts)
        if table_contains(lsp_all, "html") then
          require("lspconfig").html.setup({
            capabilities = require("configs.lsp.capabilities"),
          })
        end
      end,

      prismals = function(_, opts)
        if table_contains(lsp_all, "prismals") then
          require("lspconfig").prismals.setup({
            capabilities = require("configs.lsp.capabilities"),
          })
        end
      end,
    },
    -- Configure `vim.lsp.handlers`
    lsp_handlers = require("configs.lsp.handlers"),
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      -- map mode (:h map-modes)
      n = {
        -- a binding with no condition and therefore is always added
        gl = {
          function() vim.diagnostic.open_float() end,
          desc = "Hover diagnostics",
        },
        -- condition for only server with declaration capabilities
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        -- condition with a full function with `client` and `bufnr`
        ["<leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client, bufnr)
            return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens
          end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = require("configs.lsp.attach").on_attach
  },
}
