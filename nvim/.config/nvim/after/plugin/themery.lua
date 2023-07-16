require("themery").setup({
    themes = {
        "tokyonight-moon",
        "tokyonight-storm",
        "tokyonight-night",
        "tokyonight-day",
        "zephyr",
        "onenord",
        "onenord-light",
        "poimandres",
        {
            name = "everforest",
            colorscheme = "everforest",
            before = [[
                vim.opt.background = 'dark'
                vim.g.everforest_background = 'hard'
                vim.g.everforest_better_performance = 1
            ]],
        },
    },
    livePreview = true,
    themeConfigFile = "~/.config/nvim/lua/mecha/theme.lua",
})
