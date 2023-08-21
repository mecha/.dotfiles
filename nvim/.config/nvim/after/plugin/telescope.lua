local actions = require("telescope.actions")
local trouble = require('trouble.providers.telescope')

require("telescope").setup({
    defaults = {
        mappings = {
            i = { ["<C-t>"] = trouble.open_with_trouble },
            n = { ["<C-t>"] = trouble.open_with_trouble },
        }
    },
})
