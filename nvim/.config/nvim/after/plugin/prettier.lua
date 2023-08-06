local prettier = require("prettier")

prettier.setup({
    bin = "prettierd",
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "rust",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
})
