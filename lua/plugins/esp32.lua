local system_clangd = vim.fn.exepath "clangd"
local is_windows = vim.fn.has "win32" == 1
local executable_suffix = is_windows and ".exe" or ""

local function tool_roots()
  local roots = {}
  local seen = {}

  local function add(path)
    if path ~= "" and not seen[path] then
      seen[path] = true
      table.insert(roots, path)
    end
  end

  local idf_tools_path = vim.env.IDF_TOOLS_PATH
  if idf_tools_path and idf_tools_path ~= "" then
    add(idf_tools_path)
    add(vim.fs.joinpath(idf_tools_path, "tools"))
  end

  add(vim.fs.joinpath(vim.env.HOME or vim.fn.expand "~", ".espressif", "tools"))
  if is_windows then add "C:/Espressif/tools" end

  return roots
end

local function latest_path(pattern)
  local candidates = vim.fn.glob(pattern, false, true)
  table.sort(candidates)
  return candidates[#candidates]
end

local function find_esp_clangd()
  for _, root in ipairs(tool_roots()) do
    local clangd = latest_path(root .. "/esp-clangd/*/esp-clangd/bin/clangd" .. executable_suffix)
      or latest_path(root .. "/esp-clang/*/esp-clang/bin/clangd" .. executable_suffix)
    if clangd and vim.fn.executable(clangd) == 1 then return clangd end
  end
end

local function find_esp_clang_resource_dir()
  for _, root in ipairs(tool_roots()) do
    local resource_dir = latest_path(root .. "/esp-clang/*/esp-clang/lib/clang/*")
    if resource_dir and vim.uv.fs_stat(resource_dir) then return resource_dir end
  end
end

local esp_clangd = find_esp_clangd()
local esp_clang_resource_dir = find_esp_clang_resource_dir()

local function find_root(bufnr, predicate)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local start = name ~= "" and vim.fs.dirname(name) or vim.uv.cwd()
  if predicate(start) then return start end
  for dir in vim.fs.parents(start) do
    if predicate(dir) then return dir end
  end
end

local function is_esp_idf_root(dir)
  if vim.uv.fs_stat(dir .. "/sdkconfig") or vim.uv.fs_stat(dir .. "/sdkconfig.defaults") then return true end

  local cmake = dir .. "/CMakeLists.txt"
  if not vim.uv.fs_stat(cmake) then return false end
  return table.concat(vim.fn.readfile(cmake, "", 80), "\n"):find("tools/cmake/project%.cmake") ~= nil
end

local function project_root(bufnr, on_dir)
  local root = find_root(bufnr, is_esp_idf_root)
  if not root then
    root = find_root(bufnr, function(dir)
      if vim.uv.fs_stat(dir .. "/.cproject") or vim.fn.glob(dir .. "/*.ioc") ~= "" then return true end
      return vim.uv.fs_stat(dir .. "/CMakeLists.txt") ~= nil
        and (vim.fn.glob(dir .. "/*.ld") ~= "" or vim.fn.glob(dir .. "/*arm-none-eabi*.cmake") ~= "")
    end)
  end
  root = root or vim.fs.root(vim.api.nvim_buf_get_name(bufnr), {
    ".clangd",
    "compile_commands.json",
    "compile_flags.txt",
    "CMakeLists.txt",
    ".git",
  })
  if root then on_dir(root) end
end

---@type LazySpec
return {
  {
    "Aietes/esp32.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.clangd_args = opts.clangd_args or {}
      if esp_clang_resource_dir then
        table.insert(opts.clangd_args, "--resource-dir=" .. esp_clang_resource_dir)
      end
      return opts
    end,
    config = function(_, opts)
      local esp32 = require "esp32"
      esp32.setup(opts)

      local plugin_find_esp_clangd = esp32.find_esp_clangd
      esp32.find_esp_clangd = function()
        if esp_clangd and vim.fn.executable(esp_clangd) == 1 then return esp_clangd end
        return plugin_find_esp_clangd()
      end
    end,
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        if type(key[1]) == "string" then key[1] = key[1]:gsub("^<leader>R", "<leader>r") end
        if key[1] == "<leader>r" and key.group == "ESP32" then key.desc = "ESP32" end
        if type(key.desc) == "string" then key.desc = key.desc:gsub("^ESP32:%s*", "") end
      end
      return keys
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = vim.tbl_filter(function(mapping)
        return mapping[1] ~= "<leader>R"
      end, opts.spec or {})
      table.insert(opts.spec, { "<leader>r", group = "󰍛 ESP32" })
      table.insert(opts.spec, { "<leader>m", group = "󰍛 STM32" })
      return opts
    end,
  },
  {
    "AstroNvim/astrolsp",
    dependencies = { "Aietes/esp32.nvim" },
    opts = function(_, opts)
      opts.config = opts.config or {}
      local esp32 = require "esp32"
      local esp_config = esp32.lsp_config()
      local arm_gcc = vim.fn.exepath "arm-none-eabi-gcc"
      local arm_query_driver = arm_gcc ~= "" and vim.fs.dirname(arm_gcc) .. "/arm-none-eabi-*" or "arm-none-eabi-*"

      opts.config.clangd = vim.tbl_deep_extend("force", esp_config, {
        root_dir = project_root,
        cmd = function(dispatchers, config)
          if config.root_dir and is_esp_idf_root(config.root_dir) then return esp_config.cmd(dispatchers, config) end

          return vim.lsp.rpc.start({
            system_clangd ~= "" and system_clangd or "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--query-driver=" .. arm_query_driver,
          }, dispatchers, {
            cwd = config.cmd_cwd or config.root_dir,
            env = config.cmd_env,
            detached = config.detached,
          })
        end,
      })
    end,
  },
}
