return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = {
          cmd = { "jdtls" },
          filetypes = { "java" },
          root_dir = require("lspconfig.util").root_pattern(".git", "pom.xml", "build.gradle"),
          settings = {
            java = {
              format = {
                enabled = true,
                settings = {
                  url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                  profile = "GoogleStyle",
                },
              },
            },
          },
        },
      },
    },
  },
}
