return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown"
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian\\ Vault/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian\\ Vault/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/Users/benkulakofsky/Documents/Obsidian Vault/",
      },
    },
    ui = { enable = false },
  },
}
