return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "C-]>",
        },
      },

      should_attach = function(bufnr)
        -- If DSA mode is ON, never attach
        if vim.g.dsa_mode then
          return false
        end

        -- Normal behavior
        local ft = vim.bo[bufnr].filetype
        if ft == "markdown" or ft == "gitcommit" then
          return false
        end

        return true
      end,
    })
  end,
}
