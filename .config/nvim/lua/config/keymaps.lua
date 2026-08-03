-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- H and L navigate to top and bottom of screen
vim.keymap.set("n", "<leader>h", "H", { desc = "Top of screen" })
vim.keymap.set("n", "<leader>l", "L", { desc = "Bottom of screen" })
