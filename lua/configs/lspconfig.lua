local settings = require("configuration")
local showdiag = settings.show_diagnostics
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
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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

-- require("utils").on_attach(function(client, buffer)
--   require("configs.lsp.navic").attach(client, buffer)
--   require("configs.lsp.lspkeymaps").attach(client, buffer)
--   require("configs.lsp.keymaps").on_attach(client, buffer)
--   require("configs.lsp.inlayhints").attach(client, buffer)
--   require("configs.lsp.gitsigns").attach(client, buffer)
--   require("configs.lsp.python").attach(client, buffer)
-- end)

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

vim.cmd([[ do User LspAttachBuffers ]])

-- Diagnostic keymaps
keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { noremap = true, silent = true, desc = "Go to previous diagnostic" }
)
keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { noremap = true, silent = true, desc = "Go to next diagnostic" }
)
keymap.set(
  "n",
  "<leader>de",
  vim.diagnostic.open_float,
  { noremap = true, silent = true, desc = "Open floating diagnostic" }
)
keymap.set(
  "n",
  "<leader>dq",
  vim.diagnostic.setloclist,
  { noremap = true, silent = true, desc = "Diagnostics location list" }
)
keymap.set("n", "<leader>dt", toggle_diagnostics, { desc = "Toggle diagnostics" })
keymap.set("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
