return {
  {
    "saghen/blink.cmp",
    opts = {
      enabled = function()
        return vim.g.blink_cmp_enabled ~= false
      end,
    },
    keys = {
      {
        "<leader>tc",
        function()
          vim.g.blink_cmp_enabled = not (vim.g.blink_cmp_enabled ~= false)
          vim.notify("blink.cmp " .. (vim.g.blink_cmp_enabled and "enabled" or "disabled"))
        end,
        desc = "Toggle completion",
      },
    },
  },
}
