vim.g.mapleader = " "

require("config.lazy")
require("config.keymaps")
require("config.set")
require("config.color")

-- Ensure Neovim can find Mason-installed executables
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
