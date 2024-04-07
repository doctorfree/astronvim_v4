---@type LazySpec
return {
  {
    "axelvc/template-string.nvim",
    lazy = false,
    opts = {
      jsx_brackets = true,
      remove_template_strings = true,
      restore_quotes = {
        normal = [["]],
        jsx = [["]],
      },
    },
  },
  { "marilari88/twoslash-queries.nvim" },
  {
    'David-Kunz/cmp-npm',
    ft = "json",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
}
