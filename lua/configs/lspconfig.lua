local settings = require("configuration")
local lsp_servers = settings.lsp_servers
local lsp_installed = settings.lsp_installed
local lsp_all = require("utils").concat_tables(lsp_servers, lsp_installed)
local formatters_linters = settings.formatters_linters
local showdiag = settings.show_diagnostics
local table_contains = require("utils").table_contains
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local diagnostic = vim.diagnostic

local open_float = "<cmd>lua vim.diagnostic.open_float()<cr>"
if not showdiag == "popup" then
  open_float = ""
end

-- Style floating windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Borders for LspInfo winodw
require("lspconfig.ui.windows").default_options.border = "rounded"

api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      keymap.set(mode, lhs, rhs, { buffer = true })
    end

    -- Displays hover information about the symbol under the cursor
    bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

    -- Jump to the definition
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

    -- Jump to declaration
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

    -- Lists all the implementations for the symbol under the cursor
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

    -- Jumps to the definition of the type symbol
    bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

    -- Lists all the references
    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

    -- Displays a function's signature information
    bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

    -- Renames all references to the symbol under the cursor
    bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

    -- Selects a code action available at the current cursor position
    bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

    -- Show diagnostics in a floating window
    bufmap("n", "gl", open_float)

    -- Move to the previous diagnostic
    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

    -- Move to the next diagnostic
    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
  end,
})

require("utils").on_attach(function(client, buffer)
  require("configs.lsp.navic").attach(client, buffer)
  require("configs.lsp.lspkeymaps").attach(client, buffer)
  require("configs.lsp.keymaps").on_attach(client, buffer)
  require("configs.lsp.inlayhints").attach(client, buffer)
  require("configs.lsp.gitsigns").attach(client, buffer)
  require("configs.lsp.python").attach(client, buffer)
end)

-- diagnostics
for name, icon in pairs(require("icons").diagnostics) do
  name = "DiagnosticSign" .. name
  fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
if showdiag == "none" then
  diagnostic.config(require("configs.lsp.diagnostics")["off"])
else
  diagnostic.config(require("configs.lsp.diagnostics")["on"])
end

-- Show line diagnostics automatically in hover window
if showdiag == "popup" then
  vim.cmd([[
    autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
  ]])
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation
local diagnostics_active = true
local toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    diagnostic.show()
  else
    diagnostic.hide()
  end
end

fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

diagnostic.config({
  update_in_insert = false,
})

local capabilities = require("configs.lsp.capabilities")
local handlers = require("configs.lsp.handlers")
local lspconfig = require("lspconfig")
local navic = require("nvim-navic")

if table_contains(lsp_all, "tailwindcss") then
  lspconfig.tailwindcss.setup({
    capabilities = require("configs.lsp.servers.tailwindcss").capabilities,
    filetypes = require("configs.lsp.servers.tailwindcss").filetypes,
    handlers = handlers,
    init_options = require("configs.lsp.servers.tailwindcss").init_options,
    on_attach = require("configs.lsp.servers.tailwindcss").on_attach,
    settings = require("configs.lsp.servers.tailwindcss").settings,
  })
end

if table_contains(lsp_all, "cssls") then
  lspconfig.cssls.setup({
    capabilities = capabilities,
    handlers = handlers,
    on_attach = require("configs.lsp.servers.cssls").on_attach,
    settings = require("configs.lsp.servers.cssls").settings,
  })
end

if table_contains(lsp_all, "vuels") then
  lspconfig.vuels.setup({
    filetypes = require("configs.lsp.servers.vuels").filetypes,
    handlers = handlers,
    init_options = require("configs.lsp.servers.vuels").init_options,
    on_attach = require("configs.lsp.servers.vuels").on_attach,
    settings = require("configs.lsp.servers.vuels").settings,
  })
end

if table_contains(lsp_all, "eslint") then
  lspconfig.eslint.setup({
    cmd = { "vscode-eslint-language-server", "--stdio" },
    capabilities = capabilities,
    handlers = handlers,
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
  })
end

if table_contains(lsp_all, "tsserver") then
  if settings.typescript_server == "tsserver" then
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

      navic.attach(client, bufnr)
    end

    lspconfig.tsserver.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = tsserver_on_attach,
      settings = require("configs.lsp.servers.tsserver").settings,
    })
  end
end

local other_servers_with_navic = {
  "awk_ls",
  "rust_analyzer",
  "ansiblels",
  "cmake",
}
local check_servers_with_navic = {
  "cssmodules_ls",
  "dockerls",
  "marksman",
  "sqlls",
  "texlab",
}
for _, server in ipairs(check_servers_with_navic) do
  if table_contains(lsp_all, server) then
    table.insert(other_servers_with_navic, server)
  end
end
for _, server in ipairs(other_servers_with_navic) do
  if lspconfig[server] then
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
      end,
    })
  end
end

local setup_servers = function()
  vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)

  require("astrocore").event "LspSetup"
end
local astrocore = require "astrocore"
if astrocore.is_available "mason-lspconfig.nvim" then
  astrocore.on_load("mason-lspconfig.nvim", setup_servers)
else
  setup_servers()
end

vim.cmd([[ do User LspAttachBuffers ]])

-- Diagnostic keymaps
keymap.set("n",
  "[d",
  vim.diagnostic.goto_prev,
  { noremap = true, silent = true, desc = "Go to previous diagnostic" }
)
keymap.set("n",
  "]d",
  vim.diagnostic.goto_next,
  { noremap = true, silent = true, desc = "Go to next diagnostic" }
)
keymap.set("n",
  "<leader>de",
  vim.diagnostic.open_float,
  { noremap = true, silent = true, desc = "Open floating diagnostic" }
)
keymap.set("n",
  "<leader>dq",
  vim.diagnostic.setloclist,
  { noremap = true, silent = true, desc = "Diagnostics location list" }
)
keymap.set("n",
  "<leader>dt",
  toggle_diagnostics,
  { desc = "Toggle diagnostics" }
)
keymap.set("n",
  "L",
  "<cmd>lua vim.lsp.buf.signature_help()<CR>",
  { desc = "Signature help"}
)
