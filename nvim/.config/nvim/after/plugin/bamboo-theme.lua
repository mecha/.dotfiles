local bamboo = require("bamboo")

bamboo.setup({
    style = "multiplex",
    transparent = true,
    highlights = {
        ["Visual"] = { bg = "#585e55" },
        ["CursorLine"] = { bg = "#434a40" },
        ["IndentBlanklineChar"] = { fg = "#484e45" },
        ["@comment"] = { fg = "#6b775d" },
    },
})

bamboo.load()
