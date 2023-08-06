require("nvim-treesitter.configs").setup({
    textobjects = {
        select = {
            enabled = true,
            keymaps = {
                ["if"] = "@function.inner",
                ["af"] = "@function.outer",
                ["ic"] = "@class.inner",
                ["ac"] = "@class.outer",
                ["ib"] = "@block.inner",
                ["ab"] = "@block.outer",
                ["ir"] = "@frame.inner",
                ["ar"] = "@frame.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["i/"] = "@comment.inner",
                ["a/"] = "@comment.outer",
                ["im"] = "@parameter.inner", -- p is taken for paragraphs
                ["am"] = "@parameter.outer",
                ["ii"] = "@call.inner",      -- aka "invocation"
                ["ai"] = "@call.outer",
            },
        },
        move = {
            enabled = true,
            set_jumps = true,
        },
    },
})
