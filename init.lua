-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
if vim.g.neovide and not vim.env.IDF_PATH then
  local scripts = vim.fn.glob(vim.fn.expand "~/.espressif/tools/activate_idf_v*.sh", false, true)
  table.sort(scripts, function(left, right)
    local left_version = vim.version.parse(left:match "activate_idf_v(.+)%.sh$" or "0")
    local right_version = vim.version.parse(right:match "activate_idf_v(.+)%.sh$" or "0")
    return vim.version.lt(right_version, left_version)
  end)

  local activation_script = scripts[1]
  if activation_script then
    local result = vim.system({
      "/bin/zsh",
      "-c",
      'source "$1" >/dev/null && env -0',
      "zsh",
      activation_script,
    }, { text = false }):wait()

    if result.code == 0 then
      for entry in result.stdout:gmatch "([^%z]+)" do
        local name, value = entry:match "^([^=]+)=(.*)$"
        if name then vim.env[name] = value end
      end
    else
      vim.notify("ESP-IDF activation failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
    end
  end
end

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
