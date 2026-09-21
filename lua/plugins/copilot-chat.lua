---@type LazySpec
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    version = false,
    branch = "main",
    opts = {
      model = "auto",
      show_help = false,
      window = {
        layout = "vertical",
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = opts.options.g.copilot_chat_prefix
          local float = { window = { layout = "float" } }

          local function select_prompt(selection_type)
            return function()
              require("CopilotChat").select_prompt(vim.tbl_extend("force", {
                selection = require("CopilotChat.select")[selection_type],
              }, float))
            end
          end

          local function quick_chat(selection_type)
            return function()
              vim.ui.input({ prompt = "Quick Chat: " }, function(input)
                if input ~= nil and input ~= "" then
                  require("CopilotChat").ask(input, vim.tbl_extend("force", {
                    selection = require("CopilotChat.select")[selection_type],
                  }, float))
                end
              end)
            end
          end

          maps.n[prefix .. "p"] = { select_prompt "buffer", desc = "Prompt actions" }
          maps.v[prefix .. "p"] = { select_prompt "visual", desc = "Prompt actions" }
          maps.n[prefix .. "q"] = { quick_chat "buffer", desc = "Quick Chat" }
          maps.v[prefix .. "q"] = { quick_chat "visual", desc = "Quick Chat" }
        end,
      },
    },
  },
}
