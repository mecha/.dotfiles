local wk = require("which-key")

wk.setup({
    icons = {
        breadcrumb = "»",
        separator = "❱",
        group = " ",
    },
})

wk.register({
    g = { name = "Goto/Git" },
    s = { name = "Search" },
    c = { name = "Code" },
    cl = { name = "LSP" },
    cs = { name = "Swap" },
    h = { name = "Harpoon" },
    u = { name = "UI" },
    w = { name = "Windows" },
    b = { name = "Buffers" },
    x = { name = "Diagnostics" },
    q = { name = "Quit" },
}, { prefix = "<leader>" })
