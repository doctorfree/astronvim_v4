-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

-- We use the LSP server setting 'lsp_installed' in lua/configuration.lua
local settings = require("configuration")
local lsp_install = settings.lsp_installed

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
    -- Customize lsp formatting options
    formatting = {
      -- Control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- Disable formatting capabilities for the listed language servers
        -- Disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- Enable servers that you already have installed without mason
    servers = lsp_install,
    -- Configure buffer local user commands to add when attaching a language server
    commands = {
      Format = {
        function() vim.lsp.buf.format() end,
        -- Condition to create the user command
        -- Can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        cond = "textDocument/formatting",
        -- The rest of the user command options (:h nvim_create_user_command)
        desc = "Format file with LSP",
      },
    },
    -- Configure default capabilities for language servers (`:h vim.lsp.protocol.make_client.capabilities()`)
    capabilities = {
      textDocument = {
        foldingRange = { dynamicRegistration = false },
      },
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    -- A custom flags table to be passed to all language servers  (`:h lspconfig-setup`)
    flags = {
      exit_timeout = 5000,
    },
    -- Configure how language servers get set up
    -- A function without a key is simply the default handler, functions take
    -- two parameters, the server name and the configured options table for that server
    --     function(server, opts) require("lspconfig")[server].setup(opts) end
    -- The key is the server that is being setup with `lspconfig`
    -- Setting a handler to false will disable the set up of that language server
    --     rust_analyzer = false,
    -- Or a custom handler function can be passed
    --     pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end
    handlers = {
      -- Default handler, first entry with no key
      function(server, opts) require("lspconfig")[server].setup(opts) end,
      -- Custom function handler for pyright
      pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end,
      -- set to false to disable the setup of a language server
      rust_analyzer = false,
    },
    -- Configure `vim.lsp.handlers`
    lsp_handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true }),
      ["textDocument/signatureHelp"] = false, -- set to false to disable any custom handlers
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
    -- Mappings added when attaching a language server during the core `on_attach`
    -- The first key into the table is the vim map mode (`:h map-modes`), and the
    -- value is a table of entries to be passed to `vim.keymap.set` (`:h vim.keymap.set`):
    --   The key is the first parameter or the vim mode (only a single mode supported)
    --   and the value is a table of keymaps within that mode:
    --   The first element with no key in the table is the action (the 2nd parameter)
    --   and the rest of the keys/value pairs are options for the third parameter.
    --   There is also a special `cond` key which can either be a string of a language
    --   server capability or a function with `client` and `bufnr` parameters that returns
    --   a boolean of whether or not the mapping is added.
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
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
