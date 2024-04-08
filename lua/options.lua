-- set vim options here (vim.<first_key>.<second_key> = value)
local utils = require "utils"

require "keymaps"

vim.opt.shortmess:append "c"
vim.opt.formatoptions:remove "c"
vim.opt.formatoptions:remove "r"
vim.opt.formatoptions:remove "o"
vim.opt.fillchars:append "stl: "
vim.opt.fillchars:append "eob: "
vim.opt.fillchars:append "fold: "
vim.opt.fillchars:append "foldopen: "
vim.opt.fillchars:append "foldsep: "
vim.opt.fillchars:append "foldclose:"

vim.g.pymode = 1
vim.g.pymode_warnings = 1
vim.g.loaded_perl_provider = 0

-- The Homebrew installation location
local brew_prefix = os.getenv "HOMEBREW_PREFIX"

if brew_prefix ~= nil then
  if utils.isdir "/home/linuxbrew/.linuxbrew" then
    vim.g.homebrew_install_dir = "/home/linuxbrew/.linuxbrew"
  else
    if utils.isdir "/opt/homebrew" then
      vim.g.homebrew_install_dir = "/opt/homebrew"
    else
      if utils.isdir "/usr/local" then
        vim.g.homebrew_install_dir = "/usr/local"
      else
        vim.g.homebrew_install_dir = ""
      end
    end
  end
else
  vim.g.homebrew_install_dir = "/usr"
end

local home = os.getenv "HOME"
-- Python venv home
if home ~= nil then
  if utils.isdir(home .. "/.pyenv") then
    vim.g.pyenv_home = home .. "/.pyenv"
  else
    vim.g.pyenv_home = ""
  end
  if utils.isdir(home .. "/.local/bin") then
    vim.g.local_bin = home .. "/.local/bin"
  else
    vim.g.local_bin = ""
  end
end

local python_path = vim.fn.exepath "python3"
if python_path == nil or python_path == "" then
  python_path = vim.g.pyenv_home .. "/shims/python3"
  if utils.file_or_dir_exists(python_path) then
    vim.g.python3_host_prog = python_path
  else
    python_path = vim.g.homebrew_install_dir .. "/bin/python3"
    if utils.file_or_dir_exists(python_path) then vim.g.python3_host_prog = python_path end
  end
else
  vim.g.python3_host_prog = python_path
end

-- First check rubygems user dir then system dir
local ruby_path = ""
if vim.fn.executable "ruby" == 1 then
  ruby_path = vim.fn.system { "ruby", "-e", "puts Gem.user_dir" }
  if ruby_path == nil or ruby_path == "" then
    ruby_path = vim.fn.system { "ruby", "-e", "puts Gem.dir" }
    if ruby_path == nil or ruby_path == "" then
      ruby_path = vim.g.homebrew_install_dir .. "/bin/ruby"
      if utils.file_or_dir_exists(ruby_path) then
        ruby_path = vim.fn.system { ruby_path, "-e", "puts Gem.user_dir" }
        if ruby_path == nil or ruby_path == "" then
          ruby_path = vim.fn.system { ruby_path, "-e", "puts Gem.dir" }
          if not (ruby_path == nil or ruby_path == "") then
            ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
            if utils.file_or_dir_exists(ruby_path) then vim.g.ruby_host_prog = ruby_path end
          end
        else
          ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
          if utils.file_or_dir_exists(ruby_path) then vim.g.ruby_host_prog = ruby_path end
        end
      end
    else
      ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
      if utils.file_or_dir_exists(ruby_path) then vim.g.ruby_host_prog = ruby_path end
    end
  else
    ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
    if utils.file_or_dir_exists(ruby_path) then vim.g.ruby_host_prog = ruby_path end
  end
end

local doq_path = vim.fn.exepath "doq"
if doq_path == nil or doq_path == "" then
  doq_path = vim.g.local_bin .. "/doq"
  if utils.file_or_dir_exists(doq_path) then
    vim.g.pydocstring_doq_path = doq_path
  else
    doq_path = vim.g.homebrew_install_dir .. "/bin/doq"
    if utils.file_or_dir_exists(doq_path) then
      vim.g.pydocstring_doq_path = doq_path
    else
      vim.g.pydocstring_doq_path = "/usr/bin/doq"
    end
  end
else
  vim.g.pydocstring_doq_path = doq_path
end
