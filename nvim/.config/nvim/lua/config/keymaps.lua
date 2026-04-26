-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Disable which-key trigger for <C-Y>
require("which-key").setup({
  triggers_blacklist = {
    i = { "<C-Y>" }, -- ignore <C-Y> in insert mode
    n = { "<C-Y>" }, -- ignore <C-Y> in normal mode
  },
})
vim.keymap.set("n", "<leader>t", ":tab sball<CR>", { silent = true })
vim.keymap.set("n", "<leader>hh", function()
  Snacks.dashboard()
end, { desc = "Open LazyVim Home" })
vim.keymap.set("n", "<leader>fd", function()
  vim.cmd("call delete(expand('%')) | bdelete!")
end, { desc = "Delete File + Close Buffer" })
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("w") -- save file
  vim.cmd("!g++ -std=c++17 -O2 % -o %< && ./%<")
end, { desc = "Compile and Run C++" })
for i = 1, 9 do
  vim.keymap.set("n", tostring(i), function()
    vim.cmd(i .. "tabnext")
  end, { desc = "Go to tab " .. i })
end
