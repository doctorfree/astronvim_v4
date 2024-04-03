-- Partially borrowed from Ecovim: https://github.com/ecosse3/nvim
local lspkind = require("lspkind")
local types = require("cmp.types")

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end
require("luasnip.loaders.from_vscode").lazy_load()
local snippet_path = vim.fn.stdpath("config") .. "/snippets"
require("luasnip.loaders.from_snipmate").load({ path = { snippet_path }, })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Command Line                                             │
-- ╰──────────────────────────────────────────────────────────╯
cmp.setup.filetype("java", {
  completion = {
    keyword_length = 2,
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Highlight Groups                                         │
-- ╰──────────────────────────────────────────────────────────╯
local highlights = {
  CmpItemKindSnippet = { fg = "#A2D5A2", bg = "NONE" },
  CmpItemMenu = { fg = "#7D7DD0", bg = "NONE" },
  CmpItemAbbrMatch = { fg = "#569CD6", bg = "NONE" },
  CmpItemAbbrMatchFuzzy = { fg = "#569CD6", bg = "NONE" },
}

for group, hl in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, hl)
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Utils                                                    │
-- ╰──────────────────────────────────────────────────────────╯
local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local function deprioritize_snippet(entry1, entry2)
  if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return false
  end
  if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return true
  end
end

local function limit_lsp_types(entry, ctx)
  local kind = entry:get_kind()
  local line = ctx.cursor.line
  local col = ctx.cursor.col
  local char_before_cursor = string.sub(line, col - 1, col - 1)
  local char_after_dot = string.sub(line, col, col)

  if char_before_cursor == "." and char_after_dot:match("[a-zA-Z]") then
    if
        kind == types.lsp.CompletionItemKind.Method
        or kind == types.lsp.CompletionItemKind.Field
        or kind == types.lsp.CompletionItemKind.Property
    then
      return true
    else
      return false
    end
  elseif string.match(line, "^%s+%w+$") then
    if kind == types.lsp.CompletionItemKind.Function or kind == types.lsp.CompletionItemKind.Variable then
      return true
    else
      return false
    end
  end

  return true
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯
local icons = require("icons")
local source_mapping = {
  npm = icons.misc.terminal .. "NPM",
  nvim_lsp = icons.misc.paragraph .. "LSP",
  buffer = icons.misc.buffer .. "BUF",
  nvim_lua = icons.misc.bomb,
  luasnip = icons.misc.snippet .. "SNP",
  calc = icons.misc.calculator,
  path = icons.misc.folderOpen2,
  treesitter = icons.misc.tree,
  zsh = icons.misc.terminal .. "ZSH",
}
for k,v in pairs(icons.kinds) do source_mapping[k] = v end

local buffer_option = {
  -- Complete from all visible buffers (splits)
  get_bufnrs = function()
    local bufs = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      bufs[vim.api.nvim_win_get_buf(win)] = true
    end
    return vim.tbl_keys(bufs)
  end,
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<C-h>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Get the item with kind from the lspkind plugin
      local item_with_kind = require("lspkind").cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        symbol_map = source_mapping,
      })(entry, vim_item)

      item_with_kind.kind = lspkind.symbolic(item_with_kind.kind, { with_text = true })
      item_with_kind.menu = source_mapping[entry.source.name]
      item_with_kind.menu = vim.trim(item_with_kind.menu or "")
      item_with_kind.abbr = string.sub(item_with_kind.abbr, 1, item_with_kind.maxwidth)

      if string.find(vim_item.kind, "Color") then
        -- Override for plugin purposes
        vim_item.kind = "Color"
        local tailwind_item = require("cmp-tailwind-colors").format(entry, vim_item)
        item_with_kind.menu = lspkind.symbolic("Color", { with_text = false }) .. " Color"
        item_with_kind.kind = " " .. tailwind_item.kind
      end

      return item_with_kind
    end,
  },
  sources = {
    { name = "nvim_lsp",    priority = 8, entry_filter = limit_lsp_types, },
    { name = "luasnip",     priority = 9, max_item_count = 5 },
    {
      name = "buffer",
      priority = 5,
      keyword_length = 5,
      option = buffer_option,
      max_item_count = 5
    },
    { name = "nvim_lua",    priority = 4 },
    { name = "path",        priority = 3 },
    { name = "calc",        priority = 2 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      deprioritize_snippet,
      cmp.config.compare.exact,
      cmp.config.compare.locality,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.offset,
      cmp.config.compare.sort_text,
      cmp.config.compare.order,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    }),
  },
  experimental = {
    ghost_text = true,
  },
})
