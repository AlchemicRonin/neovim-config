---@type LazySpec
return {
  {
    "segfaultzz/nvim-site",
    name = "stm32.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function(plugin) vim.opt.rtp:append(plugin.dir .. "/nvim") end,
    config = function() require("stm32").setup() end,
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>m"] = false,
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "cortex-debug" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jedrzejboczar/nvim-dap-cortex-debug",
      "stm32.nvim",
    },
    keys = {
      {
        "<Leader>dt",
        function()
          require("dapui").close()
          require("dap").terminate()
          require("dap").repl.close()
        end,
        desc = "Terminate and close debug UI",
      },
    },
    config = function(...)
      require("astronvim.plugins.configs.nvim-dap")(...)

      require("dap-cortex-debug").setup { node_path = "node" }

      local dap = require "dap"
      dap.providers.configs.stm32 = function(bufnr)
        local stm32 = require "stm32"
        local project = stm32.project(bufnr)
        return project and { stm32.launch_config(project), stm32.attach_config(project) } or {}
      end

      local launch_json = dap.providers.configs["dap.launch.json"]
      if launch_json then
        dap.providers.configs["dap.launch.json"] = function(bufnr)
          return vim.tbl_map(require("stm32.vscode").adapt, launch_json(bufnr))
        end
      end

      require("stm32.peripherals").setup_dap()
    end,
  },
}
