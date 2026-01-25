return {
  -- Ensure TypeScript tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "typescript-language-server",
        "prettierd",
        "eslint_d",
      })
    end,
  },

  -- Configure TypeScript LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = { -- the newer name for tsserver
          settings = {
            typescript = {
              format = { enable = false }, -- disable built-in formatting (use prettier via conform)
            },
            javascript = {
              format = { enable = false },
            },
          },
        },
      },
    },
  },

  -- Treesitter for TS/JS highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "typescript", "tsx", "javascript", "json" })
    end,
  },
}
