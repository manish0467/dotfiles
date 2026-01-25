return {
  -- Core DB plugin
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIFindBuffer", "DBUIRenameBuffer" },
  },

  -- Fancy UI for databases
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle" },
    init = function()
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"
    end,
  },

  -- SQL completion
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql" },
    dependencies = { "tpope/vim-dadbod" },
  },
}
