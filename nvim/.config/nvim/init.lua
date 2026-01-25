-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.user_emmet_expandabbr_key = "<C-y>,"
require("config.lazy")
require("config.dsa")
vim.cmd([[filetype plugin indent on | syntax enable | set autoindent smartindent expandtab shiftwidth=4 softtabstop=4]])
