require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "php" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    auto_install = true,

    indent = { enable = true },

    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    },

    -- nvim-treesitter-textobjects
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Function (outer)" },
                ["if"] = { query = "@function.inner", desc = "Function (inner)" },
                ["ac"] = { query = "@class.outer", desc = "Around class" },
                ["ic"] = { query = "@class.inner", desc = "Class (inner)" },
                ["as"] = { query = "@scope", query_group = "locals", desc = "Scope" },
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>cs<Right>"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>cs<Left>"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "Next function (start)" },
                ["]c"] = { query = "@class.outer", desc = "Next class (start)" },
            },
            goto_next_end = {
                ["]F"] = { query = "@function.outer", desc = "Next function (end)" },
                ["]C"] = { query = "@class.outer", desc = "Next class (end)" },
            },
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "Prev function (start)" },
                ["[c"] = { query = "@class.outer", desc = "Prev class (start)" },
            },
            goto_previous_end = {
                ["[F"] = { query = "@function.outer", desc = "Prev function (end)" },
                ["[C"] = { query = "@class.outer", desc = "Prev class (end)" },
            },
        },
    },

    -- nvim-ts-autotags
    autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "tsx",
            "jsx",
            "rescript",
            "xml",
            "php",
            "markdown",
            "astro",
            "glimmer",
            "handlebars",
            "hbs",
        },
    },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
        spacing = 5,
        severity_limit = "Warning",
    },
    update_in_insert = true,
})
