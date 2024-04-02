return function(_, opts)
  require("which-key").setup(opts)
  require("astrocore").which_key_register()
end
