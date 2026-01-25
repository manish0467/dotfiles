return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Append active LSP names to the right-hand side of the statusline
      table.insert(opts.sections.lualine_x, function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if not clients or #clients == 0 then
          return ""
        end
        local names = {}
        for _, client in pairs(clients) do
          table.insert(names, client.name)
        end
        return " " .. table.concat(names, ", ")
      end)
    end,
  },
}
