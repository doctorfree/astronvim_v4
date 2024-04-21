local M = {}
local fn = vim.fn
local Util = require("lazy.core.util")

M.root_patterns = { ".git", "lua", "package.json", "mvnw", "gradlew", "pom.xml", "build.gradle", "release", ".project" }

M.has = function(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

--- @param on_attach fun(client, buffer)
M.on_attach = function(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

M.map = function(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  -- do not create the keymap if a lazy keys handler exists
  if keys ~= nil then
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
      opts = opts or {}
      opts.silent = opts.silent ~= false
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end
end

M.concat_tables = function(t1, t2)
  for _,v in ipairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

M.table_contains = function(tbl, x)
  local found = false
  for _, v in pairs(tbl) do
    if v == x then
      found = true
    end
  end
  return found
end

M.file_exists = function(path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

--- Check if a file or directory exists in this path
M.file_or_dir_exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

--- Check if a directory exists in this path
M.isdir = function(path)
  -- "/" works on both Unix and Windows
  return M.file_or_dir_exists(path .. "/")
end

M.get_relative_fname = function()
  local fname = fn.expand("%:p")
  return fname:gsub(fn.getcwd() .. "/", "")
end

M.get_relative_gitpath = function()
  local fpath = fn.expand("%:h")
  local fname = fn.expand("%:t")
  local gitpath = fn.systemlist("git rev-parse --show-toplevel")[1]
  local relative_gitpath = fpath:gsub(gitpath, "") .. "/" .. fname

  return relative_gitpath
end

M.sleep = function(n)
  os.execute("sleep " .. tonumber(n))
end

M.toggle_quicklist = function()
  if fn.empty(fn.filter(fn.getwininfo(), "v:val.quickfix")) == 1 then
    vim.cmd("copen")
  else
    vim.cmd("cclose")
  end
end

M.starts_with = function(str, start)
  return str:sub(1, #start) == start
end

M.end_with = function(str, ending)
  return ending == "" or str:sub(-#ending) == ending
end

M.split = function(s, delimiter)
  local result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end

  return result
end

M.handle_job_data = function(data)
  if not data then
    return nil
  end
  if data[#data] == "" then
    table.remove(data, #data)
  end
  if #data < 1 then
    return nil
  end
  return data
end

M.log = function(message, title)
  require("notify")(message, "info", { title = title or "Info" })
end

M.warnlog = function(message, title)
  require("notify")(message, "warn", { title = title or "Warning" })
end

M.errorlog = function(message, title)
  require("notify")(message, "error", { title = title or "Error" })
end

M.jobstart = function(cmd, on_finish)
  local has_error = false
  local lines = {}

  local function on_event(_, data, event)
    if event == "stdout" then
      data = M.handle_job_data(data)
      if not data then
        return
      end

      for i = 1, #data do
        table.insert(lines, data[i])
      end
    elseif event == "stderr" then
      data = M.handle_job_data(data)
      if not data then
        return
      end

      has_error = true
      local error_message = ""
      for _, line in ipairs(data) do
        error_message = error_message .. line
      end
      M.log("Error during running a job: " .. error_message)
    elseif event == "exit" then
      if not has_error then
        on_finish(lines)
      end
    end
  end

  fn.jobstart(cmd, {
    on_stderr = on_event,
    on_stdout = on_event,
    on_exit = on_event,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

M.remove_whitespaces = function(string)
  return string:gsub("%s+", "")
end

M.add_whitespaces = function(number)
  return string.rep(" ", number)
end

M.get_highlight_value = function(group)
  local found, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
  if not found then
    return {}
  end
  local hl_config = {}
  for key, value in pairs(hl) do
    _, hl_config[key] = pcall(string.format, "#%02x", value)
  end
  return hl_config
end

M.float_term = function(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end

--- get os type
---@return string the os type "osx|linux|other|unknown"
M.get_os_type = function()
  local homedir = os.getenv("HOME")
  local user = os.getenv("USER")
  local start_i = 0
  local end_i = 0

  if homedir == nil or user == nil then
    return "unknown"
  end

  start_i, end_i = string.find(homedir, "/home/" .. user)

  if start_i ~= nil and end_i ~= nil then
    return "linux"
  else
    start_i, end_i = string.find(homedir, "/Users/" .. user)
    if start_i ~= nil and end_i ~= nil then
      return "osx"
    else
      return "other"
    end
  end
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
M.get_root = function()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

M.set_root = function(dir)
  vim.api.nvim_set_current_dir(dir)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
M.toggle = function(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      Util.info("Enabled " .. option, { title = "Option" })
    else
      Util.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

---@param type "ivy" | "dropdown" | "cursor" | nil
M.telescope_theme = function(type)
  if type == nil then
    return {
      borderchars = M.generate_borderchars("thick"),
      layout_config = {
        width = 80,
        height = 0.5,
      },
    }
  end
  return require("telescope.themes")["get_" .. type]({
    cwd = M.get_root(),
    borderchars = M.generate_borderchars("thick", nil, { top = "█", top_left = "█", top_right = "█" }),
  })
end

---@param type "ivy" | "dropdown" | "cursor" | nil
M.telescope = function(builtin, type, opts)
  local params = { builtin = builtin, type = type, opts = opts }
  return function()
    builtin = params.builtin
    type = params.type
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
    local theme
    if vim.tbl_contains({ "ivy", "dropdown", "cursor" }, type) then
      theme = M.telescope_theme(type)
    else
      theme = opts
    end
    require("telescope.builtin")[builtin](theme)
  end
end

M.on_very_lazy = function(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

M.capabilities = function(ext)
  return vim.tbl_deep_extend(
    "force",
    {},
    ext or {},
    require("cmp_nvim_lsp").default_capabilities(),
    { textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } } }
  )
end

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

-- check if a variable is empty or nil
M.isEmpty = function(s)
  return s == nil or s == ""
end

--- Check if path exists
M.path_exists = function(path)
  return vim.loop.fs_stat(path)
end

-- Return telescope files command
M.project_files = function()
  local path = vim.loop.cwd() .. "/.git"
  if M.path_exists(path) then
    return "Telescope git_files"
  else
    return "Telescope find_files"
  end
end

M.notify = function(msg, level, opts)
  opts = opts or {}
  level = vim.log.levels[level:upper()]
  if type(msg) == "table" then
    msg = table.concat(msg, "\n")
  end
  local nopts = { title = "Nvim" }
  if opts.once then
    return vim.schedule(function()
      vim.notify_once(msg, level, nopts)
    end)
  end
  vim.schedule(function()
    vim.notify(msg, level, nopts)
  end)
end

--- @param type "thin" | "thick" | "empty" | nil
--- @param order "t-r-b-l-tl-tr-br-bl" | "tl-t-tr-r-bl-b-br-l" | nil
--- @param opts BorderIcons | nil
M.generate_borderchars = function(type, order, opts)
  if order == nil then
    order = "t-r-b-l-tl-tr-br-bl"
  end
  local border_icons = require("icons").borders
  --- @type BorderIcons
  local border = vim.tbl_deep_extend("force", border_icons[type or "empty"], opts or {})

  local borderchars = {}

  local extractDirections = (function()
    local index = 1
    return function()
      if index == nil then
        return nil
      end
      -- Find the next occurence of `char`
      local nextIndex = string.find(order, "-", index)
      -- Extract the first direction
      local direction = string.sub(order, index, nextIndex and nextIndex - 1)
      -- Update the index to nextIndex
      index = nextIndex and nextIndex + 1 or nil
      return direction
    end
  end)()

  local mappings = {
    t = "top",
    r = "right",
    b = "bottom",
    l = "left",
    tl = "top_left",
    tr = "top_right",
    br = "bottom_right",
    bl = "bottom_left",
  }
  local direction = extractDirections()
  while direction do
    if mappings[direction] == nil then
      M.notify(string.format("Invalid direction '%s'", direction), "error")
    end
    borderchars[#borderchars + 1] = border[mappings[direction]]
    direction = extractDirections()
  end

  if #borderchars ~= 8 then
    M.notify(string.format("Invalid order '%s'", order), "error")
  end

  return borderchars
end

return M
