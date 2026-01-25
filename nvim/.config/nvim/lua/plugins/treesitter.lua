return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      -- silently exit if not yet loaded
      return
    end

    configs.setup({
      ensure_installed = {
        "lua",
        "html",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "css",
        "python",
        "bash",
        "java",
        "dart",
      },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    })
  end,
}
