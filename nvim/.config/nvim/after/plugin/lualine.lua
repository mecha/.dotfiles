local noice = require("noice")

require("lualine").setup({
    options = {
        theme = "tokyonight",
    },
    sections = {
        lualine_x = {
            {
                noice.api.statusline.mode.get,
                cond = noice.api.statusline.mode.has,
                color = { fg = "#ff9e64" },
            },
        },
    },
})
