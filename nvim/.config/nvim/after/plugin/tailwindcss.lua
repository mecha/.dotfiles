require("lspconfig").tailwindcss.setup({
    filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
        "vue",
        "postcss",
    },
    on_attach = function(client, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
    end,
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    "className\\s*[=:]\\s*[`'\"]([\\s\\S]*?)[`'\"]",
                },
            },
        },
    },
})
