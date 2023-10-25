-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("mecha_yank_highlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("mecha_auto_write_dir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Bash LSP
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})

-- Set tmux window title to file name
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost", "BufNewFile", "BufEnter" }, {
    callback = function(event)
        local file = vim.loop.fs_realpath(event.match) or event.match
        local name = vim.fn.fnamemodify(file, ":t")
        if name ~= "" then
            vim.fn.system({ "tmux", "rename-window", name })
        end
    end,
})

-- Reset tmux window title to default when appropriate
vim.api.nvim_create_autocmd({ "BufDelete", "VimLeave" }, {
    callback = function()
        vim.fn.system({ "tmux", "setw", "automatic-rename" })
    end,
})
