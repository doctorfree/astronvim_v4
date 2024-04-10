local settings = require("configuration")
local Util = require("utils")
local plugin = require("utils.plugin")
local map = Util.map
local keymap = vim.keymap.set
local silent = { silent = true }
local Info = require("lazy.core.util").info

-- Open links under cursor in browser with gx
if vim.fn.has "macunix" == 1 then
  keymap("n", "gx", "<cmd>silent execute '!open ' . shellescape('<cWORD>')<CR>", silent)
else
  keymap("n", "gx", "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<CR>", silent)
end

-- LSP
keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
keymap("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", silent)
keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", silent)
keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", silent)
keymap("v", "<leader>cf", function()
  local start_row, _ = table.unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_row, _ = table.unpack(vim.api.nvim_buf_get_mark(0, ">"))

  vim.lsp.buf.format {
    range = {
      ["start"] = { start_row, 0 },
      ["end"] = { end_row, 0 },
    },
    async = true,
  }
end, silent)
keymap("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)

-- highlights under cursor
if vim.fn.has "nvim-0.9.0" == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- floating terminal
map("n", "<leader>ft", function()
  Util.float_term(nil, { cwd = Util.get_root() })
end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function()
  Util.float_term()
end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
