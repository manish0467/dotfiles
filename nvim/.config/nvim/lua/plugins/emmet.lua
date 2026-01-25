return {
  "mattn/emmet-vim",
  lazy = false, -- FORCE LOAD, no event delays
  init = function()
    -- Enable everywhere (normal, insert, visual)
    vim.g.user_emmet_mode = "a"

    -- Keybinding: <C-y>,
    vim.g.user_emmet_leader_key = "<C-e>"

    -- Optional: filetype extensions
    vim.g.user_emmet_settings = {
      ["html"] = { extends = "html" },
      ["javascriptreact"] = { extends = "jsx" },
      ["typescriptreact"] = { extends = "jsx" },
      ["vue"] = { extends = "html" },
      ["svelte"] = { extends = "html" },
    }
  end,
}
