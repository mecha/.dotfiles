return {
    ------------------------------------------------------------------------------------------------
    -- LSP & Coding
    ------------------------------------------------------------------------------------------------
    {
        -- Zero-config LSP
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            {
                -- LSP manager
                "williamboman/mason.nvim",
                config = true,
                build = ":MasonUpdate",
            },
            -- Quickstart configs for LSP
            { "neovim/nvim-lspconfig" },
            -- Integrate Mason & lspconfig
            { "williamboman/mason-lspconfig.nvim" },
            {
                -- Code snippets
                "L3MON4D3/LuaSnip",
                version = "1.*",
                build = "make install_jsregexp",
                dependencies = {
                    -- Collection of snippets
                    "rafamadriz/friendly-snippets",
                },
            },
            {
                -- Auto-completion engine
                "hrsh7th/nvim-cmp",
                dependencies = {
                    -- Icons in cmp menu
                    "onsails/lspkind-nvim",
                },
            },
            -- LSP auto-completions entries
            { "hrsh7th/cmp-nvim-lsp" },
            -- Snippets auto-completion entries
            { "saadparwaiz1/cmp_luasnip" },
        },
    },
    -- Use Nvim as LSP to inject LSP diagnostics, code actions, etc. using Lua
    { "jose-elias-alvarez/null-ls.nvim" },
    -- GitHub Copilot
    { "github/copilot.vim" },
    -- Prettier integration
    { "MunifTanjim/prettier.nvim" },
    {
        -- Syntax highlighting and AST manipulations
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    -- Show treesitter AST
    { "nvim-treesitter/playground" },
    -- Add selection objects for classes, functions, params, args, etc.
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    -- Auto-insert and auto-rename closing tags in HTML, JSX, TSX, XML, etc.
    { "windwp/nvim-ts-autotag" },
    -- Highlight colors in the buffer
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                tailwind = true,
            },
        },
    },
    -- Tailwind extension for nvim-colorizer and nvim-cmp
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = true,
    },
    ------------------------------------------------------------------------------------------------
    -- Navigation & Search
    ------------------------------------------------------------------------------------------------
    {
        -- Fuzzy-finding
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
        },
    },
    -- Make Tmux & Nvim pane navigation seamless
    { "alexghergh/nvim-tmux-navigation" },
    -- Quick jump list
    { "ThePrimeagen/harpoon" },
    -- Search highlighting
    { "kevinhwang91/nvim-hlslens" },
    ------------------------------------------------------------------------------------------------
    -- Editing
    ------------------------------------------------------------------------------------------------
    -- Change history and branching
    { "mbbill/undotree" },
    -- Auto-commenting lines & blocks
    { "terrortylor/nvim-comment" },
    -- Highlight occurrences of word/symbol under cursor using LSP
    { "RRethy/vim-illuminate" },
    {
        -- Surround text with pairs: (), [], {}, <>, "", '', ``
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },
    {
        -- Highlight keywords in comments: TODO, NOTE, HACK, etc.
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    -- Improved dot-repeat
    { "tpope/vim-repeat" },
    -- Leap motions
    { "ggandor/leap.nvim" },
    -- Indentation lines
    { "lukas-reineke/indent-blankline.nvim" },
    -- Improved f/F/t/T motions
    -- { "ggandor/flit.nvim", config = true },
    ------------------------------------------------------------------------------------------------
    -- UI
    ------------------------------------------------------------------------------------------------
    {
        -- UI replacer for messages, cmdline, popupmenu, etc.
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            { "MunifTanjim/nui.nvim", lazy = true },
            "rcarriga/nvim-notify",
        },
    },
    {
        -- Improve default Vim UIs (e.g. Mason language filter)
        "stevearc/dressing.nvim",
        opts = {},
    },
    {
        -- Sidebar file tree
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },
    {
        -- Popup that shows available key binds
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    {
        -- Better status bar
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    },
    {
        -- List for diagnostics, references, quick fixes, locations, telescope results, etc.
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        -- Close buffers without fucking up the window layout
        "echasnovski/mini.bufremove",
        version = false,
        config = true,
    },
    ------------------------------------------------------------------------------------------------
    -- Color schemes
    ------------------------------------------------------------------------------------------------
    { "ribru17/bamboo.nvim" },
    ------------------------------------------------------------------------------------------------
    -- Git
    ------------------------------------------------------------------------------------------------
    {
        -- Open LazyGit in floating window
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    -- Git gutter status
    { "lewis6991/gitsigns.nvim" },
}
