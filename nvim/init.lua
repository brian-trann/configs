vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }
}

local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
-- Default options:
require("gruvbox").setup()
vim.cmd("colorscheme gruvbox")
vim.wo.relativenumber = true
vim.cmd("set number")
vim.cmd("set guicursor=n-v-c-i:block")
local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua", "javascript", "html", "typescript", "json"},
    highlight = { enable = true },
    indent = { enable = true }
})
