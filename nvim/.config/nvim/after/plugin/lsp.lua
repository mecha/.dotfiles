local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset({})
lsp.extend_cmp()

lsp.ensure_installed({
    "tsserver",
    "phpactor",
    "rust_analyzer",
})

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-u>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-e>"] = cmp.mapping.select_next_item(cmp_select),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp.setup({
    mappings = cmp_mappings,
    formatting = {
        format = function(entry, item)
            require("lspkind").cmp_format()(entry, item)
            return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end,
    },
    -- snippet = {
    --     expand = function(args)
    --         require("luasnip").lsp_expand(args.body)
    --     end,
    -- },
    -- sources = {
    --     { name = "luasnip" },
    -- },
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    local opts = function(desc)
        return { desc = desc, buffer = bufnr, remap = false }
    end

    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format" })

    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts("Definition"))
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts("References"))
    vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, opts("Hover"))
    vim.keymap.set("n", "<leader>cc", ":lua require('neogen').generate()<cr>", { desc = "Annotate" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Actions"))
    vim.keymap.set("n", "<leader>cA", function()
        vim.lsp.buf.code_action({
            context = {
                only = { "source" },
                diagnostics = {},
            },
        })
    end, { desc = "Source Action" })

    vim.keymap.set("n", "<leader>x", function() end, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>xx", vim.diagnostic.show, opts("Diagnostics [Panel]"))
    vim.keymap.set("n", "<leader>xn", vim.diagnostic.open_float, opts("Diagnostics [Float]"))

    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("Hover"))
end)

lspconfig["tailwindcss"].setup({
    on_attach = function(client, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
    end,
})

lsp.setup()
