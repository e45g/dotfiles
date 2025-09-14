return {
    {
        "lervag/vimtex",
        lazy = false,  -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            vim.g.vimtex_compiler_latexmk = {
                build_dir = "/tmp/mynotes_build",  -- aux files go here
                options = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                },
            }

            vim.g.vimtex_compiler_latexmk.build_dir = "/tmp/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. "_build"

            -- VimTeX configuration
            vim.g.tex_flavor='latex'
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_quickfix_mode = 0
        end
    }
}
