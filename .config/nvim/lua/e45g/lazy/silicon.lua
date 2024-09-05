return {
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
    }
