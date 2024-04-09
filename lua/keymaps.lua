local settings = require "configuration"
local Util = require "utils"
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

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Toggle keymaps
map("n", "<leader>uf", require("configs.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function()
  Util.toggle "spell"
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  Util.toggle "wrap"
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
  Util.toggle("relativenumber", true)
  Util.toggle "number"
end, { desc = "Toggle Line Numbers" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uC", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

map("n", "<leader>ug", function()
  if vim.wo.signcolumn == "no" then
    vim.wo.signcolumn = "yes"
  elseif vim.wo.signcolumn == "yes" then
    vim.wo.signcolumn = "auto"
  else
    vim.wo.signcolumn = "no"
  end
  Info("Set signcolumn to " .. vim.wo.signcolumn, { title = "Option" })
end, { desc = "Toggle signcolumn" })

map("n", "<leader>uL", function()
  vim.opt.showtabline = vim.api.nvim_get_option "showtabline" == 0 and 2 or 0
  Info("Set showtabline to " .. vim.api.nvim_get_option "showtabline", { title = "Option" })
end, { desc = "Toggle tabline" })

map("n", "<leader>uS", function()
  local laststatus = vim.api.nvim_get_option "laststatus"
  if laststatus == 0 then
    vim.opt.laststatus = 2
  elseif laststatus == 2 then
    vim.opt.laststatus = 3
  elseif laststatus == 3 then
    vim.opt.laststatus = 0
  end
  Info("Set laststatus to " .. vim.api.nvim_get_option "laststatus", { title = "Option" })
end, { desc = "Toggle statusline" })

map("n", "<leader>um", function()
  local mouse = vim.api.nvim_get_option "mouse"
  if mouse == "" then
    vim.opt.mouse = "nv"
    Info("Mouse Enabled: mouse = " .. vim.api.nvim_get_option "mouse", { title = "Option" })
  else
    vim.opt.mouse = ""
    Info("Mouse Disabled", { title = "Option" })
  end
end, { desc = "Toggle mouse" })

map("n", "<leader>uN", function()
  local number = vim.wo.number -- local to window
  local relativenumber = vim.wo.relativenumber -- local to window
  if not number and not relativenumber then
    vim.wo.number = true
    Info("Set number to true", { title = "Option" })
  elseif number and not relativenumber then
    vim.wo.relativenumber = true
    Info("Set relativenumber to true", { title = "Option" })
  elseif number and relativenumber then
    vim.wo.number = false
    Info("Set number to false", { title = "Option" })
  else -- not number and relativenumber
    vim.wo.relativenumber = false
    Info("Set relativenumber to false", { title = "Option" })
  end
end, { desc = "Toggle number" })
map("n", "<leader>x", require("utils.functions").toggle_colorcolumn, { desc = "Toggle colorcolumn" })

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

-- Open the URL of the plugin spec or 'user/repo' path under the cursor
vim.api.nvim_create_user_command("OpenRepo", function(_)
  local ghpath = vim.api.nvim_eval("shellescape(expand('<cfile>'))")
  local formatpath = ghpath:sub(2, #ghpath - 1)
  local repourl = "https://www.github.com/" .. formatpath
  if formatpath:sub(1, 5) == "http:" or formatpath:sub(1, 6) == "https:" then
    repourl = formatpath
  end
  if vim.fn.has("mac") == 1 then
    vim.fn.system({ "open", repourl })
  else
    if vim.fn.executable("gio") then
      vim.fn.system({ "gio", "open", repourl })
    else
      vim.fn.system({ "xdg-open", repourl })
    end
  end
end, {
  desc = "Open URL",
  force = true,
})

map("n", "gh", "<cmd>OpenRepo<CR>", { desc = "Open URL" })
