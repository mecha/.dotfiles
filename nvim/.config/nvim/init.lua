local nvim_path = debug.getinfo(1).source:match("@?(.*/)")
local lazy_path = nvim_path .. "/lazy"
local plugins_path = nvim_path .. "/plugins"

-- Clone Lazy if missing
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazy_path,
    })
end

-- Set up Lazy
local plugins = require("mecha.plugins")
vim.opt.rtp:prepend(lazy_path)
require("lazy").setup(plugins, { root = plugins_path })

-- Load my config
require("mecha")
