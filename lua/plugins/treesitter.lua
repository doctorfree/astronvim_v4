return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bash",
      "json",
      "jsonc",
      "lua",
      "luap",
      "markdown",
      "markdown_inline",
      "php",
      "python",
      "regex",
      "toml",
      "vim",
      "yaml",
    })
    opts.auto_install = true
  end,
}
