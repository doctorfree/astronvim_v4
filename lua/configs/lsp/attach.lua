local settings = require("configuration")
local showdiag = settings.show_diagnostics
local attach = {}

-- set quickfix list from diagnostics in a buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
  local diagnostics = nil
  diagnostics = vim.diagnostic.get(buf_num, { severity = severity })
  local qf_items = vim.diagnostic.toqflist(diagnostics)
  vim.fn.setqflist({}, " ", { title = "Diagnostics", items = qf_items })
  -- open quickfix by default
  vim.cmd [[copen]]
end

-- A custom `on_attach` function to be run after the default `on_attach` function
-- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
attach.on_attach = function(client, bufnr)
  -- Mappings.
  local map = function(mode, l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
  map("n", "<C-]>", vim.lsp.buf.definition)
  map("n", "K", vim.lsp.buf.hover, { desc = "Display symbol info in float" })
  map("n", "<C-k>", vim.lsp.buf.signature_help)
  -- map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "variable rename" })
  map("n", "gr", vim.lsp.buf.references, { desc = "Show References" })
  map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
  map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
  -- this puts diagnostics from opened files to quickfix
  map("n", "<leader>qw", vim.diagnostic.setqflist, { desc = "Put window diagnostics to qf" })
  -- this puts diagnostics from current buffer to quickfix
  map("n", "<leader>qb", function()
    set_qflist(bufnr)
  end, { desc = "Put buffer diagnostics to qf" })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Code" })
  end

  vim.api.nvim_create_autocmd("CursorHold", {
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

      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      if
        (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
        and #vim.diagnostic.get() > 0
      then
        if showdiag == "popup" then
          vim.diagnostic.open_float(nil, float_opts)
        end
      end

      vim.b.diagnostics_pos = cursor_pos
    end,
  })

  if vim.g.logging_level == "debug" then
    local msg = string.format("Language server %s started!", client.name)
    vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
  end
end

return attach
