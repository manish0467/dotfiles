return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Merge with LazyVim’s defaults
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
      })

      -- Define prettierd formatter (faster than prettier)
      opts.formatters = opts.formatters or {}
      opts.formatters.prettierd = {
        command = "prettierd",
        args = { "$FILENAME" },
        stdin = true,
      }
    end,
  },
}
