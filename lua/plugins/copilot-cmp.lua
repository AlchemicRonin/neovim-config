---@type LazySpec
return {
  "zbirenbaum/copilot-cmp",
  config = function(_, opts)
    -- Upstream still uses the deprecated client.is_stopped() dot-call.
    local source = require "copilot_cmp.source"
    function source:is_available()
      if self.client.name ~= "copilot" or self.client:is_stopped() then return false end
      return next(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf(), id = self.client.id }) ~= nil
    end
    require("copilot_cmp").setup(opts)
  end,
}
