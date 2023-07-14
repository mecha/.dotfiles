local wk = require("which-key")

wk.setup()

wk.register({
    c = { name = "+Code" },
    cl = { name = "+LSP" },
    g = { name = "+Goto/Git" },
    w = { name = "+Windows" },
    b = { name = "+Buffers" },
    n = { name = "+Notifications" },
    h = { name = "+Harpoon" },
    s = { name = "+Search" },
    u = { name = "+UI" },
    q = { name = "+Quit" },
    x = { name = "+Diagnostics" },
}, { prefix = "<leader>" })
