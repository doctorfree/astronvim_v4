local navic = require("nvim-navic")
local icons = require("icons")

vim.g.navic_silence = true
vim.api.nvim_set_hl(0, "NavicText", { link = "Comment" })
vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Comment" })

navic.setup {
    lsp = {
        auto_attach = true,
        preference = { "pylsp", "pyright" },
    },
    highlight = true,
    separator = " " .. icons.misc.caretRight .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    icons = icons.kinds,
    safe_output = true
}
