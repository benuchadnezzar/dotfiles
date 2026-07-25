-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Open Neo-tree automatically when Neovim starts
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open Neo-tree on startup",
  callback = function()
    require("neo-tree.command").execute({ action = "show" })
  end,
})

-- Reopen Neo-tree any time it's not visible
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Keep Neo-tree open",
  callback = function()
    local neotree_open = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == "neo-tree" then
        neotree_open = true
        break
      end
    end
    if not neotree_open then
      vim.schedule(function()
        require("neo-tree.command").execute({ action = "show" })
      end)
    end
  end,
})

-- Get rid of "No Name" buffer that opens on startup
vim.api.nvim_create_autocmd("BufHidden", {
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) == "" and not vim.bo[buf].modified then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end)
    end
  end,
})
