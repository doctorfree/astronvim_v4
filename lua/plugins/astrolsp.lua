-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

local settings = require "configuration"
local lsp_servers = settings.lsp_servers
local lsp_installed = settings.lsp_installed
local lsp_all = require("utils").concat_tables(lsp_servers, lsp_installed)
local formatters_linters = settings.formatters_linters
local external_formatters = settings.external_formatters
local showdiag = settings.show_diagnostics
local table_contains = require("utils").table_contains
local fn = vim.fn
local api = vim.api

-- disable formatting capabilities for the listed language servers
local disable_format = {}
if table_contains(formatters_linters, "stylua") then
  -- disable lua_ls formatting capability when using StyLua to format lua code
  disable_format = { "lua_ls" }
end

local bashls_enabled = { enabled = false }
local bashls_settings = {}
if table_contains(lsp_all, "bashls") then
  bashls_settings = {
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
  bashls_enabled = { settings = bashls_settings }
end

local venv_path = os.getenv "VIRTUAL_ENV"
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

local pylsp_enabled = { enabled = false }
if table_contains(lsp_all, "pylsp") then
  pylsp_enabled = {
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
            live_mode = false,
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
  }
end
local pyright_enabled = { enabled = false }
if table_contains(lsp_all, "pyright") then
  pyright_enabled = {
    settings = {
      python = {
        analysis = {
          indexing = true,
          typeCheckingMode = "basic",
          diagnosticMode = "workspace",
          autoImportCompletions = true,
          autoSearchPaths = true,
          inlayHints = {
            variableTypes = true,
            functionReturnTypes = true,
          },
          useLibraryCodeForTypes = true,
          diagnosticSeverityOverrides = {
            reportGeneralTypeIssues = "none",
            reportOptionalMemberAccess = "none",
            reportOptionalSubscript = "none",
            reportPrivateImportUsage = "none",
            reportUnusedExpression = "none",
          },
        },
      },
    },
  }
end
local lua_ls_enabled = { enabled = false }
if table_contains(lsp_all, "lua_ls") then
  lua_ls_enabled = {
    -- Note: These settings will meaningfully increase the time until lua_ls
    -- can service initial requests (completion, location) upon starting as well
    -- as time to first diagnostics. Completion results will include a workspace
    -- indexing progress message until the server has finished indexing.
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
  }
end

local vimls_enabled = { enabled = false }
if table_contains(lsp_all, "vimls") then
  vimls_enabled = {
    flags = {
      debounce_text_changes = 500,
    },
  }
end

local tailwind_enabled = { enabled = false }
if table_contains(lsp_all, "tailwindcss") then
  tailwind_enabled = {
    capabilities = require("configs.lsp.servers.tailwindcss").capabilities,
    filetypes = require("configs.lsp.servers.tailwindcss").filetypes,
    init_options = require("configs.lsp.servers.tailwindcss").init_options,
    on_attach = require("configs.lsp.servers.tailwindcss").on_attach,
    settings = require("configs.lsp.servers.tailwindcss").settings,
  }
end

local cssls_enabled = { enabled = false }
if table_contains(lsp_all, "cssls") then
  cssls_enabled = {
    on_attach = require("configs.lsp.servers.cssls").on_attach,
    settings = require("configs.lsp.servers.cssls").settings,
  }
end

local vuels_enabled = { enabled = false }
if table_contains(lsp_all, "vuels") then
  vuels_enabled = {
    filetypes = require("configs.lsp.servers.vuels").filetypes,
    init_options = require("configs.lsp.servers.vuels").init_options,
    on_attach = require("configs.lsp.servers.vuels").on_attach,
    settings = require("configs.lsp.servers.vuels").settings,
  }
end

local eslint_enabled = { enabled = false }
if table_contains(lsp_all, "eslint") then
  eslint_enabled = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
      "svelte",
      "astro",
    },
    root_dir = require("lspconfig.util").root_pattern(".git"),
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine",
        },
        showDocumentation = {
          enable = true,
        },
      },
      codeActionOnSave = {
        enable = false,
        mode = "all",
      },
      experimental = {
        useFlatConfig = false,
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      packageManager = "npm",
      problems = {
        shortenToSingleLine = false,
      },
      quiet = false,
      rulesCustomizations = {},
      run = "onType",
      useESLintClass = false,
      validate = "on",
      workingDirectory = {
        mode = "location",
      },
    },
    on_attach = function(_, bufnr)
      api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  }
end

local tsserver_enabled = { enabled = false }
if table_contains(lsp_all, "tsserver") then
  -- make sure to only run this once!
  local formatter_bin = "eslint_d"
  if table_contains(formatters_linters, "prettier") then
    formatter_bin = "prettier"
  end
  local tsserver_on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls or conform
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup({
      enable_import_on_completion = true,
      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = false,
      eslint_opts = {},
      -- formatting
      enable_formatting = true,
      formatter = formatter_bin,
      formatter_opts = {},
      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    api.nvim_buf_set_keymap(bufnr, "n", ",go", ":TSLspOrganize<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", ",gR", ":TSLspRenameFile<CR>", opts)
    api.nvim_buf_set_keymap(bufnr, "n", ",gi", ":TSLspImportAll<CR>", opts)
  end

  tsserver_enabled = {
    on_attach = tsserver_on_attach,
    settings = require("configs.lsp.servers.tsserver").settings,
  }
end

local ccls_enabled = { enabled = false }
if table_contains(lsp_all, "ccls") then
  ccls_enabled = {
    init_options = {
      cache = {
        directory = ".ccls-cache",
      },
      highlight = {
        lsRanges = true,
      },
    },
  }
end
local clangd_enabled = { enabled = false }
if table_contains(lsp_all, "clangd") then
  clangd_enabled = {
    filetypes = { "c", "cpp", "cc", "mpp", "ixx", "objc", "objcpp", "cuda" },
    flags = {
      debounce_text_changes = 500,
      fallbackFlags = {
        "--query-driver=/**/*",
        "--clang-tidy",
        "--header-insertion=never",
        "--offset-encoding=utf-16",
      },
    },
    on_attach = function(client, bufnr)
      require("clangd_extensions.inlay_hints").setup_autocmd()
      require("clangd_extensions.inlay_hints").set_inlay_hints()
    end,
  }
end
local yamlls_enabled = { enabled = false }
if table_contains(lsp_all, "yamlls") then
  yamlls_enabled = {
    schemaStore = {
      enable = true,
      url = "https://www.schemastore.org/api/json/catalog.json",
    },
    schemas = {
      kubernetes = "*.yaml",
      ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
      ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
      ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
      ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
      ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
      ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
      ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
      ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
      ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
      ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
    },
    format = { enabled = false },
    validate = false,
    completion = true,
    hover = true,
  }
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = settings.enable_autoformat, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    capabilities = require "configs.lsp.capabilities",
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
      disabled = disable_format,
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
      bashls = bashls_enabled,
      ccls = ccls_enabled,
      clangd = clangd_enabled,
      cssls = cssls_enabled,
      eslint = eslint_enabled,
      lua_ls = lua_ls_enabled,
      pylsp = pylsp_enabled,
      pyright = pyright_enabled,
      tailwindcss = tailwind_enabled,
      tsserver = tsserver_enabled,
      vimls = vimls_enabled,
      vuels = vuels_enabled,
      yamlls = yamlls_enabled,
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler,
      -- function(server, opts) require("lspconfig")[server].setup(opts) end,

      -- functions take two parameters, the server name and the
      -- configured options table for that server
      -- the key is the server that is being setup with `lspconfig`

      -- setting a handler to false will disable the set up of that language server
      rust_analyzer = false,

      pyright = function(_, opts)
        if table_contains(lsp_all, "pyright") then
          require("lspconfig").pyright.setup(opts)
        end
      end,

      bashls = function(_, opts)
        if table_contains(lsp_all, "bashls") then
          require("lspconfig").bashls.setup(opts)
        end
      end,

      lua_ls = function(_, opts)
        if table_contains(lsp_all, "lua_ls") then
          require("lspconfig").lua_ls.setup(opts)
        end
      end,

      jsonls = function(_, opts)
        if table_contains(lsp_all, "jsonls") then
          require("lspconfig").jsonls.setup {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
              },
            },
          }
        end
      end,

      pylsp = function(_, opts)
        if table_contains(lsp_all, "pylsp") then
          require("lspconfig").pylsp.setup(opts)
        end
      end,

      vimls = function(_, opts)
        if table_contains(lsp_all, "vimls") then
          require("lspconfig").vimls.setup(opts)
        end
      end,

      yamlls = function(_, opts)
        if table_contains(lsp_all, "yamlls") then
          require("lspconfig").yamlls.setup(opts)
        end
      end,

      ccls = function(_, opts)
        if fn.executable "ccls" == 1 then
          require("lspconfig").ccls.setup(opts)
        end
      end,

      clangd = function(_, opts)
        if fn.executable "clangd" == 1 then
          require("lspconfig").clangd.setup(opts)
        end
      end,

      emmet_ls = function(_, opts)
        if table_contains(lsp_all, "emmet_ls") then
          require("lspconfig").emmet_ls.setup(opts)
        end
      end,

      graphql = function(_, opts)
        if table_contains(lsp_all, "graphql") then
          require("lspconfig").graphql.setup(opts)
        end
      end,

      html = function(_, opts)
        if table_contains(lsp_all, "html") then
          require("lspconfig").html.setup(opts)
        end
      end,

      prismals = function(_, opts)
        if table_contains(lsp_all, "prismals") then
          require("lspconfig").prismals.setup(opts)
        end
      end,
    },

    -- Configure `vim.lsp.handlers`
    lsp_handlers = require "configs.lsp.handlers",

    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- Can either be a string of a client capability
        -- or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever
        -- fails for all clients, the auto commands will be deleted for that buffer

        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,

        -- List of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function()
            vim.lsp.buf.clear_references()
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      -- map mode (:h map-modes)
      n = {
        -- a binding with no condition and therefore is always added
        ["gl"] = {
          function()
            if showdiag == "popup" then
              vim.diagnostic.open_float()
            end
          end,
          desc = "Hover diagnostics",
        },
        -- condition for only server with declaration capabilities
        ["gD"] = {
          function()
            vim.lsp.buf.declaration()
          end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        -- condition with a full function with `client` and `bufnr`
        ["<leader>uY"] = {
          function()
            require("astrolsp.toggles").buffer_semantic_tokens()
          end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client, _)
            local prv_st = client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens
            return prv_st
          end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = require("configs.lsp.attach").on_attach,
  },
}
