-- local wk = require("which-key")
local present, wk = pcall(require, "which-key")
if not present then return end

wk.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    ["<space>"] = "󱁐",
    ["telescope"] = " ",
    ["Telescope"] = " ",
    ["operator"] = "",
  },
  motions = {
    count = true,
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "rounded",
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 2, 1, 2 }, -- extra window padding etop, right, bottom, lefte
    position = "bottom",
    winblend = 0,
  },
  layout = {
    height = { min = 5, max = 40 }, -- min and max height of the columns
    width = { min = 20, max = 80 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = {
    "<silent>",
    "<cmd>",
    "<Cmd>",
    "<CR>",
    "call",
    "lua",
    "^:",
    "^ ",
    "require",
    "escope",
    "erator",
    '"',
  }, --
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true,
  triggers = "auto",
  triggers_nowait = {
    -- marks
    "`",
    "'",
    "g`",
    "g'",
    -- registers
    '"',
    "<c-r>",
    -- spelling
    "z=",
  },
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local visual_opts = {
  mode = "v", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local normal_mode_mappings = {
  -- ignore
  ["1"] = "which_key_ignore",
  ["2"] = "which_key_ignore",
  ["3"] = "which_key_ignore",
  ["4"] = "which_key_ignore",
  ["5"] = "which_key_ignore",
  ["6"] = "which_key_ignore",
  ["7"] = "which_key_ignore",
  ["8"] = "which_key_ignore",
  ["9"] = "which_key_ignore",

  -- single
  -- ['='] = { '<cmd>vertical resize +5<CR>',                      'Resize +5' },
  -- ['-'] = { '<cmd>vertical resize -5<CR>',                      'Resize +5' },
  ["v"] = { "<C-W>v", "Split right" },
  ["V"] = { "<C-W>s", "Split below" },
  ["q"] = { "quicklist" },

  ["<Tab>"] = {
    name = "Tabs",
  },

  ["/"] = {
    name = "Manage",
    ["/"] = { "<cmd>Alpha<CR>", "Open dashboard" },
    m = { "<cmd>Mason<CR>", "Manage packages" },
    p = { "<cmd>Lazy<CR>", "Manage plugins" },
    u = { "<cmd>Lazy update<CR>", "Update plugins" },
    s = {
      name = "Session",
    },
  },

  a = {
    name = "Actions",
    n = { "<cmd>set nonumber!<CR>", "Line numbers" },
    r = { "<cmd>set norelativenumber!<CR>", "Relative number" },
  },

  b = {
    name = "Buffer",
    c = { '<cmd>lua require("ecovim.utils").closeOtherBuffers()<CR>', "Close but current" },
    f = { "<cmd>bfirst<CR>", "First buffer" },
    s = {
      name = "Sort",
    },
  },

  c = {
    name = "LSP",
    a = { "code action" },
    d = { "<cmd>TroubleToggle<CR>", "Local diagnostics" },
    D = { "<cmd>Telescope diagnostics wrap_results=true<CR>", "Workspace diagnostics" },
    f = { "format" },
    l = { "line diagnostics" },
    r = { "rename" },
    R = { "structural replace" },
    t = { "<cmd>LspToggleAutoFormat<CR>", "Toggle format on save" },
  },

  d = {
    name = "Debug",
    a = { "Attach" },
    b = { "Breakpoint" },
    c = { "Continue" },
    C = { "Close UI" },
    d = { "Continue" },
    e = { "Open diagnostic float" },
    h = { "Visual hover" },
    i = { "Step into" },
    o = { "Step over" },
    O = { "Step out" },
    q = { "Set diagnostics location list" },
    r = { "Repl" },
    s = { "Scopes" },
    t = { "Toggle diagnostics" },
    T = { "Terminate" },
    v = { "Log variable" },
    V = { "Log variable above" },
    w = { "Watches" },
  },

  D = {
    name = "Database",
    t = { "Toggle UI" },
    f = { "Find Buffer" },
    r = { "Rename Buffer" },
    q = { "Last Query Info" },
  },

  t = {
    name = "Terminal",
  },

  g = {
    name = "Git",
    a = { "<cmd>!git add %:p<CR>", "Add current" },
    A = { "<cmd>!git add .<CR>", "Add all" },
    b = { '<cmd>lua require("ecovim.internal.blame").open()<CR>', "Blame" },
    B = { "<cmd>Telescope git_branches<CR>", "Branches" },
    c = {
      name = "Conflict",
    },
    h = {
      name = "Hunk",
    },
    l = {
      name = "Log",
      A = { '<cmd>lua require("ecovim.plugins.telescope").my_git_commits()<CR>', "Commits (Telescope)" },
      a = { "<cmd>LazyGitFilter<CR>", "Commits" },
      C = { '<cmd>lua require("ecovim.plugins.telescope").my_git_bcommits()<CR>', "Buffer commits (Telescope)" },
      c = { "<cmd>LazyGitFilterCurrentFile<CR>", "Buffer commits" },
    },
    m = { "Blame line" },
    S = { "<cmd>Telescope git_status<CR>", "Telescope status" },
    w = {
      name = "Worktree",
      w = "Worktrees",
      c = "Create worktree",
    },
  },

  p = {
    name = "Project",
    f = { "File" },
    w = { "Word" },
    l = {
      "<cmd>lua require'telescope'.extensions.repo.cached_list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}<CR>",
      "List",
    },
    r = { "Refactor" },
    s = { "<cmd>SessionManager save_current_session<CR>", "Save session" },
    T = { "<cmd>TodoTelescope<CR>", "Todo (Telescope)" },
    t = { "<cmd>TodoTrouble<CR>", "Todo (Trouble)" },
    v = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>", "Todo/Fix/Fixme (Trouble)" },
  },

  s = {
    name = "Search",
    d = { '<cmd>lua require("ecovim.plugins.telescope").edit_neovim()<CR>', "Dotfiles" },
    h = { "<cmd>Telescope oldfiles hidden=true<CR>", "File history" },
    H = { '<cmd>lua require("ecovim.plugins.telescope").command_history()<CR>', "Command history" },
    n = { name = "Noice" },
  },

  u = {
    name = "UI",
    c = { "<cmd>Telescope colorscheme<CR>", "Color schemes" },
    T = { "<cmd>Telescope themes<CR>", "Theme switcher" },
  },

  w = {
    name = "Windows",
  },
}

local visual_mode_mappings = {
  -- single
  ["s"] = { "<cmd>'<,'>sort<CR>", "Sort" },

  a = {
    name = "Actions",
  },

  c = {
    name = "LSP",
    a = { "Range code action" },
    f = { "Range format" },
  },

  g = {
    name = "Git",
    h = {
      name = "Hunk",
      r = "Reset hunk",
      s = "Stage hunk",
    },
  },

  p = {
    name = "Project",
    r = { "Refactor" },
  },

  t = {
    name = "Table Mode",
    t = { "Tableize" },
  },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Register                                                 │
-- ╰──────────────────────────────────────────────────────────╯

wk.register(normal_mode_mappings, opts)
wk.register(visual_mode_mappings, visual_opts)

local function attach_markdown(bufnr)
  wk.register({
    a = {
      name = "Actions",
      m = { "<cmd>MarkdownPreviewToggle<CR>", "markdown preview" },
    },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_typescript(bufnr)
  wk.register({
    c = {
      name = "LSP",
      e = { "<cmd>TSC<CR>", "Workspace errors (TSC)" },
      F = { "<cmd>TSToolsFixAll<CR>", "Fix all" },
      i = { "<cmd>TSToolsAddMissingImports<CR>", "Import all" },
      o = { "<cmd>TSToolsOrganizeImports<CR>", "Organize imports" },
      s = { "<cmd>TSToolsSortImports<CR>", "Sort imports" },
      u = { "<cmd>TSToolsRemoveUnused<CR>", "Remove unused" },
    },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_npm(bufnr)
  wk.register({
    n = {
      name = "NPM",
      c = { '<cmd>lua require("package-info").change_version()<CR>', "Change version" },
      d = { '<cmd>lua require("package-info").delete()<CR>', "Delete package" },
      h = { "<cmd>lua require('package-info').hide()<CR>", "Hide" },
      i = { '<cmd>lua require("package-info").install()<CR>', "Install new package" },
      r = { '<cmd>lua require("package-info").reinstall()<CR>', "Reinstall dependencies" },
      s = { '<cmd>lua require("package-info").show()<CR>', "Show" },
      u = { '<cmd>lua require("package-info").update()<CR>', "Update package" },
    },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_zen(bufnr)
  wk.register({
    ["z"] = { "<cmd>ZenMode<CR>", "Zen Mode" },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_jest(bufnr)
  wk.register({
    j = {
      name = "Jest",
      f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', "Run current file" },
      i = { '<cmd>lua require("neotest").summary.toggle()<CR>', "Toggle info panel" },
      j = { '<cmd>lua require("neotest").run.run()<CR>', "Run nearest test" },
      l = { '<cmd>lua require("neotest").run.run_last()<CR>', "Run last test" },
      o = { '<cmd>lua require("neotest").output.open({ enter = true })<CR>', "Open test output" },
      s = { '<cmd>lua require("neotest").run.stop()<CR>', "Stop" },
    },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_spectre(bufnr)
  wk.register({
    ["R"] = { "[SPECTRE] Replace all" },
    ["o"] = { "[SPECTRE] Show options" },
    ["q"] = { "[SPECTRE] Send all to quicklist" },
    ["v"] = { "[SPECTRE] Change view mode" },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_nvim_tree(bufnr)
  wk.register({
    ["+"] = { "<cmd>NvimTreeResize +5<CR>", "Resize +5" },
    ["-"] = { "<cmd>NvimTreeResize -5<CR>", "Resize +5" },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

return {
  attach_markdown = attach_markdown,
  attach_typescript = attach_typescript,
  attach_npm = attach_npm,
  attach_zen = attach_zen,
  attach_jest = attach_jest,
  attach_spectre = attach_spectre,
  attach_nvim_tree = attach_nvim_tree,
}
