---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  -- branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "crispgm/telescope-heading.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "cljoly/telescope-repo.nvim",
    "jvgrootveld/telescope-zoxide",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>fz"] = { "<Cmd>Telescope zoxide list<CR>", desc = "Find directories" },
          },
        },
      },
    },
  },
  keys = {
    -- Search stuff
    { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Strings" },
    { "<leader>s?", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>sh", "<cmd>Telescope heading<cr>", desc = "Headings" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sO", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
    -- { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    { "<leader>sR", "<cmd>Telescope regiesters<cr>", desc = "Registers" },
    { "<leader>ss", "<cmd>Telescope grep_string<cr>", desc = "Text under cursor" },
    { "<leader>sS", "<cmd>Telescope symbols<cr>", desc = "Emoji" },
    { "<leader>s:", "<cmd>Telescope search_history<cr>", desc = "Search History" },
    { "<leader>s;", "<cmd>Telescope command_history<cr>", desc = "Command history" },
    {
      "<leader>sf",
      "<cmd>lua require'telescope.builtin'.grep_string{ shorten_path = true, word_match = '-w', only_sort_text = true, search = '' }<cr>",
      desc = "Fuzzy search",
    },
    -- Git
    { "<leader>gh", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
    { "<leader>gm", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    -- files
    { "<leader>fb", "<cmd>Telescope file_browser grouped=true<cr>", desc = "Filebrowser" },
    { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
    { "<leader>fr", "<cmd>Telescope oldfiles prompt_title=Recent<cr>", desc = "Recent files" },
    -- misc
    { "<leader>mm", "<cmd>Telescope make<cr>", desc = "Run make" },
    { "<leader>mt", "<cmd>Telescope<cr>", desc = "Telescope" },
    -- Other
    { "<leader>bB", "<cmd>Telescope buffers<cr>", desc = "Bufferlist" },
    { "<C-s>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
    { "<leader>b,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    {
      "<leader><space>",
      "<cmd>Telescope file_browser<CR>",
      desc = "Find Files (root dir)",
    },
    -- search
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    {
      "<leader>sH",
      "<cmd>Telescope highlights<cr>",
      desc = "Search Highlight Groups",
    },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    -- local theme_switch = {
    --   "<leader>uC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme with preview",
    -- }
    theme_switch = {
      "<leader>uC",
      "<cmd>Telescope themes<cr>",
      desc = "Colorscheme with preview",
    },
  },
  config = function() require "configs.telescope" end,
}
