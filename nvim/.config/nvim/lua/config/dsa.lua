-- Global DSA mode flag
vim.g.dsa_mode = true

-- Toggle function
function _G.toggle_dsa_mode()
  vim.g.dsa_mode = not vim.g.dsa_mode

  if vim.g.dsa_mode then
    vim.cmd("Copilot disable")
    vim.notify("🧠 DSA Mode ON (Copilot disabled)", vim.log.levels.WARN)
  else
    vim.cmd("Copilot enable")
    vim.notify("🤖 DSA Mode OFF (Copilot enabled)", vim.log.levels.INFO)
  end
end

-- Keymap: <leader>ud
vim.keymap.set("n", "<leader>D", toggle_dsa_mode, {
  desc = "Toggle DSA Mode (Copilot OFF)",
})
