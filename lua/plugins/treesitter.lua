if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "astro",
      "css",
      "gitcommit",
      "graphql",
      "html",
      "javascript",
      "json",
      "json5",
      "lua",
      "markdown",
      "markdown_inline",
      "prisma",
      "query",
      "regex",
      "svelte",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      -- add more arguments for adding more treesitter parsers
    })
  end,
}
