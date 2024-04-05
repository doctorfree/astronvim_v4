-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local settings = require("configuration")
local lsp_servers = settings.lsp_servers
local lsp_installed = settings.lsp_installed
local formatters_linters = settings.formatters_linters
local external_formatters = settings.external_formatters
local showdiag = settings.show_diagnostics
local table_contains = require("utils").table_contains
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local diagnostic = vim.diagnostic

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
  local diagnostics = nil
  diagnostics = diagnostic.get(buf_num, { severity = severity })
  local qf_items = diagnostic.toqflist(diagnostics)
  fn.setqflist({}, ' ', { title = 'Diagnostics', items = qf_items })
  -- open quickfix by default
  vim.cmd[[copen]]
end

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
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
      bashls = function(_, opts)
        if table_contains(lsp_servers, "bashls") then
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
      end -- or a custom handler function can be passed
    },
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
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- Mappings.
      local map = function(mode, l, r, opts)
        opts = opts or {}
        opts.silent = true
        opts.buffer = bufnr
        keymap.set(mode, l, r, opts)
      end

      map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
      map("n", "<C-]>", vim.lsp.buf.definition)
      map("n", "K", vim.lsp.buf.hover, { desc = "Display symbol info in float"})
      map("n", "<C-k>", vim.lsp.buf.signature_help)
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "varialbe rename" })
      map("n", "gr", vim.lsp.buf.references, { desc = "show references" })
      map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
      map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })
      -- this puts diagnostics from opened files to quickfix
      map("n", "<leader>qw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })
      -- this puts diagnostics from current buffer to quickfix
      map("n", "<leader>qb", function() set_qflist(bufnr) end, { desc = "put buffer diagnostics to qf" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
      map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
      map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
      map("n", "<leader>wl", function()
        vim.print(vim.lsp.buf.list_workspace_folders())
      end, { desc = "list workspace folder" })

      -- Set some key bindings conditional on server capabilities
      if client.server_capabilities.documentFormattingProvider then
        map("n", "<leader>f", vim.lsp.buf.format, { desc = "format code" })
      end

      api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local float_opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always", -- show source in diagnostic popup window
            prefix = " ",
          }

          if not vim.b.diagnostics_pos then
            vim.b.diagnostics_pos = { nil, nil }
          end

          local cursor_pos = api.nvim_win_get_cursor(0)
          if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
              and #diagnostic.get() > 0
          then
            diagnostic.open_float(nil, float_opts)
          end

          vim.b.diagnostics_pos = cursor_pos
        end,
      })

      -- The blow command will highlight the current variable and its usages in the buffer.
      if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
          hi! link LspReferenceRead Visual
          hi! link LspReferenceText Visual
          hi! link LspReferenceWrite Visual
        ]])

        local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        api.nvim_create_autocmd("CursorHold" , {
          group = gid,
          buffer = bufnr,
          callback = function ()
            vim.lsp.buf.document_highlight()
          end
        })

        api.nvim_create_autocmd("CursorMoved" , {
          group = gid,
          buffer = bufnr,
          callback = function ()
            vim.lsp.buf.clear_references()
          end
        })
      end

      if vim.g.logging_level == "debug" then
        local msg = string.format("Language server %s started!", client.name)
        vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
      end
    end
  },
}
