return function(_, opts)
  require("mason-lspconfig").setup(opts)
  require("astrocore").event "MasonLspSetup"
end
