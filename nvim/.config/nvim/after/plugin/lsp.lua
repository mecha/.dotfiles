local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset({})
lsp.extend_cmp()

lsp.ensure_installed({
    "tsserver",
    "phpactor@master",
    "rust_analyzer",
})

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

local cmp = require("cmp")

cmp.setup({
    mappings = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
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

    vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, opts("Hover"))
    vim.keymap.set("n", "<leader>cd", ":lua require('neogen').generate()<cr>", { desc = "Doc/Annotate" })

    vim.keymap.set("n", "<leader>ah", vim.lsp.buf.code_action, opts("Code actions (here)"))
    vim.keymap.set("n", "<leader>af", function()
        vim.lsp.buf.code_action({
            context = {
                only = { "source" },
                diagnostics = {},
            },
        })
    end, { desc = "Code actions (file)" })

    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("Hover"))
end)

lsp.setup()

vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if not (result and result.contents) then
    return
  end
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
  if vim.tbl_isempty(markdown_lines) then
    return
  end
  return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
end
