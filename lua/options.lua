-- set vim options here (vim.<first_key>.<second_key> = value)
local settings = require("configuration")
local utils = require("utils")

local options = {
  clipboard      = "unnamed",               --- Copy-paste between vim and everything else
  cmdheight      = 0,                       --- Give more space for displaying messages
  completeopt    = "menu,menuone,noselect", --- Better autocompletion
  cursorline     = true,                    --- Highlight of current line
  emoji          = false,                   --- Fix emoji display
  expandtab      = true,                    --- Use spaces instead of tabs
  foldcolumn     = "0",
  foldnestmax    = 0,
  foldmethod     = "expr",
  foldexpr       = "nvim_treesitter#foldexpr()",
  foldlevel      = 99,                      --- Using ufo provider need a large value
  foldlevelstart = 99,                      --- Expand all folds by default
  ignorecase     = true,                    --- Needed for smartcase
  laststatus     = 3,                       --- Global statusline at the bottom
  list           = settings.list,
  listchars      = settings.listchars,
  mouse          = settings.mouse,          --- Enable mouse
  number         = settings.number,         --- Shows current line number
  relativenumber = settings.relative_number,--- Enables relative number
  pumheight      = 10,                      --- Max num of items in completion menu
  scrolloff      = 8,                       --- Always keep space when scrolling to bottom/top edge
  shiftwidth     = 2,                       --- Number of space characters inserted for indentation
  showtabline    = settings.showtabline,    --- Always show tabs
  spell          = false, -- sets vim.opt.spell
  -- signcolumn  = "auto", -- sets vim.opt.signcolumn to auto
  signcolumn     = "yes:2",                 --- Add extra sign column next to line number
  smartcase      = true,                    --- Uses case in search
  smartindent    = true,                    --- Makes indenting smart
  smarttab       = true,                    --- Makes tabbing smarter will realize you have 2 vs 4
  softtabstop    = 2,                       --- Insert 2 spaces for a tab
  splitright     = true,                    --- Vertical splits will automatically be to the right
  swapfile       = false,                   --- Swap not needed
  tabstop        = 2,                       --- Insert 2 spaces for a tab
  termguicolors  = true,                    --- Correct terminal colors
  timeoutlen     = 300,                     --- Faster completion (cannot be lower than 200)
  ttimeoutlen    = 0,                       --- Time to wait for a key code sequence to complete
  undofile       = true,                    --- Sets undo to file
  updatetime     = 100,                     --- Faster completion
  viminfo        = "'1000",                 --- Increase the size of file history
  wildignore     = "*node_modules/**",      --- Don't search inside Node.js modules (works for gutentag)
  wrap           = true,                    --- Display long lines as just one line
  writebackup    = false,                   --- Not needed
  -- Neovim defaults
  autoindent     = true,                    --- Good auto indent
  backspace      = "indent,eol,start",      --- Making sure backspace works
  backup         = false,                   --- Recommended by coc
  -- Concealed text is completely hidden unless it has a custom replacement
  -- character defined (needed for dynamically showing tailwind classes)
  conceallevel   = 2,
  concealcursor  = "",                      --- Set to an empty string to expand tailwind class when on cursorline
  encoding       = "utf-8",                 --- The encoding displayed
  errorbells     = false,                   --- Disables sound effect for errors
  fileencoding   = "utf-8",                 --- The encoding written to file
  incsearch      = true,                    --- Start searching before pressing enter
  showmode       = false,                   --- Don't show things like -- INSERT -- anymore
}

local globals = {
  mapleader                   = settings.mapleader,      --- Map leader key
  maplocalleader              = settings.maplocalleader, --- Map local leader key
  speeddating_no_mappings     = 1,          --- Disable default mappings for speeddating
  autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
  cmp_enabled = true, -- enable completion at start
  autopairs_enabled = true, -- enable autopairs at start
  diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
  icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
  ui_notifications_enabled = true, -- disable notifications when toggling UI elements
  camelcasemotion_key = "<leader>",
  loaded_perl_provider = 0,
  sonokai_style = "andromeda",
}

vim.opt.shortmess:append('c');
vim.opt.formatoptions:remove('c');
vim.opt.formatoptions:remove('r');
vim.opt.formatoptions:remove('o');
vim.opt.fillchars:append('stl: ');
vim.opt.fillchars:append('eob: ');
vim.opt.fillchars:append('fold: ');
vim.opt.fillchars:append('foldopen: ');
vim.opt.fillchars:append('foldsep: ');
vim.opt.fillchars:append('foldclose:');

vim.g.pymode = 1
vim.g.pymode_warnings = 1
vim.g.loaded_perl_provider = 0

-- The Homebrew installation location
local brew_prefix = os.getenv("HOMEBREW_PREFIX")

if brew_prefix ~= nil then
  if utils.isdir("/home/linuxbrew/.linuxbrew") then
    vim.g.homebrew_install_dir = "/home/linuxbrew/.linuxbrew"
  else
    if utils.isdir("/opt/homebrew") then
      vim.g.homebrew_install_dir = "/opt/homebrew"
    else
      if utils.isdir("/usr/local") then
        vim.g.homebrew_install_dir = "/usr/local"
      else
        vim.g.homebrew_install_dir = ""
      end
    end
  end
else
  vim.g.homebrew_install_dir = "/usr"
end

local python_path = vim.fn.exepath("python3")
if python_path == nil or python_path == "" then
  python_path = vim.g.homebrew_install_dir .. "/bin/python3"
  if utils.file_or_dir_exists(python_path) then
    vim.g.python3_host_prog = python_path
  end
else
  vim.g.python3_host_prog = python_path
end

-- First check rubygems user dir then system dir
local ruby_path = ""
if vim.fn.executable("ruby") == 1 then
  ruby_path = vim.fn.system({ "ruby", "-e", "puts Gem.user_dir" })
  if ruby_path == nil or ruby_path == "" then
    ruby_path = vim.fn.system({ "ruby", "-e", "puts Gem.dir" })
    if ruby_path == nil or ruby_path == "" then
      ruby_path = vim.g.homebrew_install_dir .. "/bin/ruby"
      if utils.file_or_dir_exists(ruby_path) then
        ruby_path = vim.fn.system({ ruby_path, "-e", "puts Gem.user_dir" })
        if ruby_path == nil or ruby_path == "" then
          ruby_path = vim.fn.system({ ruby_path, "-e", "puts Gem.dir" })
          if not (ruby_path == nil or ruby_path == "") then
            ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
            if utils.file_or_dir_exists(ruby_path) then
              vim.g.ruby_host_prog = ruby_path
            end
          end
        else
          ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
          if utils.file_or_dir_exists(ruby_path) then
            vim.g.ruby_host_prog = ruby_path
          end
        end
      end
    else
      ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
      if utils.file_or_dir_exists(ruby_path) then
        vim.g.ruby_host_prog = ruby_path
      end
    end
  else
    ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
    if utils.file_or_dir_exists(ruby_path) then
      vim.g.ruby_host_prog = ruby_path
    end
  end
end

local doq_path = vim.fn.exepath("doq")
if doq_path == nil or doq_path == "" then
  doq_path = vim.g.homebrew_install_dir .. "/bin/doq"
  if utils.file_or_dir_exists(doq_path) then
    vim.g.pydocstring_doq_path = doq_path
  else
    vim.g.pydocstring_doq_path = "/usr/bin/doq"
  end
else
  vim.g.pydocstring_doq_path = doq_path
end

return function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  for k, v in pairs(options) do
    local_vim.opt[k] = v
  end

  for k, v in pairs(globals) do
    local_vim.g[k] = v
  end
  return local_vim
end
