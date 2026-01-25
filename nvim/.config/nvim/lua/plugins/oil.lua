return {
  "stevearc/oil.nvim",
  lazy = false, -- force loading immediately
  keys = {
    {
      "-",
      function()
        require("oil").open()
      end,
      desc = "Open parent directory (Oil)",
    },
  },
  opts = {
    default_file_explorer = true,
    view_options = { show_hidden = true },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
