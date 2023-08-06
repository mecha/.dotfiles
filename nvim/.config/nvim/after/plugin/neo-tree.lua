require("neo-tree").setup({
    sources = { "filesystem", "buffers", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    close_if_last_window = false,
    source_selector = {
        winbar = false,
        statusline = false,
    },
    filesystem = {
        bind_to_cwd = true,
        follow_current_file = true,
        use_libuv_file_watcher = true,
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
        },
    },
    window = {
        mappings = {
            ["<space>"] = "none",
        },
    },
    default_component_configs = {
        indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_empty = "󰜌",
            folder_empty_open = "󰜌",
        },
        git_status = {
            symbols = {
                renamed = "󰁕",
                unstaged = "󰄱",
            },
        },
    },
})
