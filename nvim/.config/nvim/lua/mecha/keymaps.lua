local bufremove = require("mini.bufremove")
local telescope = require("telescope.builtin")

vim.g.mapleader = " "

-- Turn that shit off
vim.keymap.set("n", "Q", "<nop>")
-- Save shortcut (for muscle memory)
vim.keymap.set("n", "<C-s>", vim.cmd.w, { desc = "Save buffer", silent = true })

-------------------------------------------------------------------------------
-- Move text
-------------------------------------------------------------------------------
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true, noremap = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true, noremap = true })
vim.keymap.set("n", "<A-Up>", "V<cmd>m .-2<cr>=", { desc = "Move line up", silent = true, noremap = true })
vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down", silent = true, noremap = true })
vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up", silent = true, noremap = true })
vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down", silent = true, noremap = true })

-------------------------------------------------------------------------------
-- Indent text
-------------------------------------------------------------------------------
vim.keymap.set("v", "<A-Left>", "<gv", { desc = "Unindent selection", silent = true, noremap = true })
vim.keymap.set("v", "<A-Right>", ">gv", { desc = "Indent selection", silent = true, noremap = true })
vim.keymap.set("n", "<A-Left>", "<<<C-Left>", { desc = "Unindent line", silent = true, noremap = true })
vim.keymap.set("n", "<A-Right>", ">><C-Right>", { desc = "Indent line", silent = true, noremap = true })
vim.keymap.set("i", "<A-Left>", "<Esc><<<C-Left>i", { desc = "Unindent line", silent = true })
vim.keymap.set("i", "<A-Right>", "<Esc>>><C-Right>i", { desc = "Indent line", silent = true })

-------------------------------------------------------------------------------
-- Void register yanking/deleting
-------------------------------------------------------------------------------
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>c", '"_c')

-------------------------------------------------------------------------------
-- Keep cursor in the middle of the screen
-------------------------------------------------------------------------------
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-------------------------------------------------------------------------------
-- BUFFERS
-------------------------------------------------------------------------------
vim.keymap.set("n", "<C-Tab>", vim.cmd.bn, { desc = "Next buffer", silent = true, noremap = true })
vim.keymap.set("n", "<C-S-Tab>", vim.cmd.bp, { desc = "Previous buffer", silent = true, noremap = true })
vim.keymap.set("n", "<leader>bd", function()
    bufremove.delete(0, false)
end, { desc = "Close buffer", silent = true })

-------------------------------------------------------------------------------
-- WINDOWS
-------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Other window", silent = true })
vim.keymap.set("n", "<leader>wd", "<C-w>q", { desc = "Close window", silent = true })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows", silent = true })

-- Resizing
vim.keymap.set("n", "<C-M-Left>", "<C-w>5<", { desc = "Decrease width", noremap = true })
vim.keymap.set("n", "<C-M-Right>", "<C-w>5>", { desc = "Increase width", noremap = true })
vim.keymap.set("n", "<C-M-Up>", "<C-w>5+", { desc = "Increase height", noremap = true })
vim.keymap.set("n", "<C-M-Down>", "<C-w>5-", { desc = "Decrease height", noremap = true })

-------------------------------------------------------------------------------
-- SPLITS
-------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>-", vim.cmd.split, { desc = "Split right" })
vim.keymap.set("n", "<leader>=", vim.cmd.vsplit, { desc = "Split down" })

-------------------------------------------------------------------------------
-- TELESCOPE
-------------------------------------------------------------------------------
local telescopeFindFiles = "<cmd>Telescope find_files hidden=true<cr>"

vim.keymap.set("n", "<leader><Space>", telescopeFindFiles, { desc = "Search files" })
vim.keymap.set("n", "<leader>sf", telescopeFindFiles, { desc = "Search files" })
vim.keymap.set("n", "<leader>st", telescope.live_grep, { desc = "Search text" })
vim.keymap.set("n", "<leader>sb", telescope.buffers, { desc = "Search buffers" })
vim.keymap.set("n", "<leader>sh", telescope.help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>sg", telescope.git_files, { desc = "Search Git files" })
vim.keymap.set("n", "<leader>sn", "<cmd>Telescope noice<cr>", { desc = "Search notifications", silent = true })
vim.keymap.set("n", "<leader>sm", "<cmd>Telescope harpoon marks<cr>", { desc = "Harpoon marks", silent = true })
vim.keymap.set("n", "<leader>sc", "/<c-r><c-w><cr>", { desc = "Find word under cursor" })

local replace = "/\\<<C-r><C-w>\\>//gI<Left><Left><Left>"

vim.keymap.set("n", "<leader>sr", ":s" .. replace, { desc = "Replace current word [line]" })
vim.keymap.set("n", "<leader>sR", ":%s" .. replace, { desc = "Replace current word [buffer]" })
-------------------------------------------------------------------------------
-- Undo tree
-------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>z", vim.cmd.UndotreeToggle, { desc = "Undo tree" })

-------------------------------------------------------------------------------
-- Neo tree
-------------------------------------------------------------------------------
vim.keymap.set(
    "n",
    "<leader>e",
    ":Neotree filesystem reveal_force_cwd toggle<CR>",
    { desc = "File tree", silent = true }
)
vim.keymap.set(
    "n",
    "<leader>k",
    ":Neotree reveal_force_cwd document_symbols toggle<CR>",
    { desc = "Symbols", silent = true }
)

-- Code
vim.keymap.set("n", "<leader>cm", vim.cmd.Mason, { desc = "Mason" })
vim.keymap.set("n", "<leader>ct", vim.cmd.TodoTelescope, { desc = "Todos (Telescope)" })
vim.keymap.set("n", "<leader>cT", vim.cmd.TodoTrouble, { desc = "Todos (Trouble)" })
-- Code -> LSP
vim.keymap.set("n", "<leader>cli", vim.cmd.LspInfo, { desc = "LSP Info" })
vim.keymap.set("n", "<leader>clr", vim.cmd.LspRestart, { desc = "LSP Restart" })
-- Code -> Swap (placeholders for which-key)
vim.keymap.set("n", "<leader>cs<left>", function() end)
vim.keymap.set("n", "<leader>cs<right>", function() end)

-------------------------------------------------------------------------------
-- HARPOON
-------------------------------------------------------------------------------
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = "Open menu" })
vim.keymap.set("n", "<leader>he", mark.add_file, { desc = "Add file" })

local harpoonNavFile = function(i)
    return function()
        ui.nav_file(i)
    end
end

-- File navigation
for i = 1, 9, 1 do
    vim.keymap.set("n", "<leader>h" .. i, harpoonNavFile(i), { desc = "File " .. i })
end

-- Quick 4-file navigation
vim.keymap.set("n", "<C-n>", harpoonNavFile(1), { desc = "Harpoon File 1" })
vim.keymap.set("n", "<C-e>", harpoonNavFile(2), { desc = "Harpoon File 2" })
vim.keymap.set("n", "<C-i>", harpoonNavFile(3), { desc = "Harpoon File 3" })
vim.keymap.set("n", "<C-o>", harpoonNavFile(4), { desc = "Harpoon File 4" })

-------------------------------------------------------------------------------
-- LAZYGIT
-------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "LazyGit", noremap = true })
vim.keymap.set("n", "<leader>gh", vim.cmd.LazyGitFilterCurrentFile, { desc = "File history", noremap = true })

-------------------------------------------------------------------------------
-- UI
-------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ut", ":Themery<cr>", { desc = "Theme" })
vim.keymap.set("n", "<leader>un", "<cmd>Noice dismiss<cr>", { desc = "Dismiss notifications" })
vim.keymap.set("n", "<leader>ul", vim.cmd.Lazy, { desc = "Lazy" })

-------------------------------------------------------------------------------
-- DIAGNOSTICS
-------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>xx", vim.diagnostic.show, { desc = "Diagnostics [Panel]", remap = false })
vim.keymap.set("n", "<leader>xn", vim.diagnostic.open_float, { desc = "Diagnostics [Float]", remap = false })
