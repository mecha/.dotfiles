require("lspconfig").tailwindcss.setup({
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
