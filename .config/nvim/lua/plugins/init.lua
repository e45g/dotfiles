return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "pmizio/typescript-tools.nvim",
        },


        config = function()
            local lspconfig = require('lspconfig')
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Set up rust-analyzer for Rust
            lspconfig.rust_analyzer.setup{
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            command = "clippy"
                        },
                    }
                }
            }

            -- Set up clangd for C
            lspconfig.clangd.setup{
                capabilities = capabilities,
            }

            -- Set up nvim-cmp
            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    -- Add other sources as needed
                },
                -- Add more cmp configuration as desired
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = function()
            return require "configs.conform"
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "eslint-lsp",
                "eslint_d",
                "lua-language-server",
                "stylua",
                "css-lsp",
                "html-lsp",
                "typescript-language-server",
                "deno",
                "prettier",
                "emmet-language-server",
                "json-lsp",
                "tailwindcss-language-server",
                "unocss-language-server",
                "shfmt",
                "shellcheck",
                "bash-language-server",
                "clangd",
                "clang-format",
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "html",
                "css",
                "javascript",
                "json",
                "toml",
                "markdown",
                "c",
                "bash",
                "rust",
                "lua",
                "tsx",
                "typescript",
            },

            autotag = {
                enable = true,
            },
        },
    },

    ---------------------------- custom plugins ----------------------------
    {
        "andweeb/presence.nvim",
        lazy = false,
        config = function()
            require("presence").setup {
                auto_update = true,
                neovim_image_text = "The One True Text Editor",
                main_image = "neovim",
                client_id = "793271441293967371",
                log_level = nil,
                debounce_timeout = 10,
                enable_line_number = false,
                blacklist = {},
                buttons = true,
                file_assets = {},
                show_time = true,

                editing_text = "Editing %s",
                file_explorer_text = "Browsing %s",
                git_commit_text = "Committing changes",
                plugin_manager_text = "Managing plugins",
                reading_text = "Reading %s",
                workspace_text = "Working on %s",
                line_number_text = "Line %s out of %s",
            }
        end,
    },
    {
        "wakatime/vim-wakatime",
        lazy = false,
    },
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "michaelrommel/nvim-silicon",
        lazy = true,
        cmd = "Silicon",
        config = function()
            require("nvim-silicon").setup {
                font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
                theme = "Dracula",
                background = "#a9a9fd",
                window_title = function()
                    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
                end,
            }
        end,
    },

    -- smooth scroll
    {
        "karb94/neoscroll.nvim",
        keys = { "<C-d>", "<C-u>" },
        config = function()
            require("neoscroll").setup()
        end,
    },

    -- dim inactive windows
    {
        "andreadev-it/shade.nvim",
        config = function()
            require("shade").setup {
                exclude_filetypes = { "NvimTree" },
            }
        end,
    },

    -- pretty diagnostics panel
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TodoTrouble" },
        dependencies = {
            {
                "folke/todo-comments.nvim",
                opts = {},
            },
        },
        config = function()
            require("trouble").setup()
        end,
    },

    -- syntax support fgor yuck lang
    {
        "elkowar/yuck.vim",
        ft = "yuck",
    },
    -- distraction free mode
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        config = function()
            require "configs.zenmode"
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        opts = {
            extensions_list = { "fzf", "terms", "nerdy", "media" },

            extensions = {
                media = {
                    backend = "ueberzug",
                },
            },
        },

        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "2kabhishek/nerdy.nvim",
            "dharmx/telescope-media.nvim",
        },
    },
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
    },
}

