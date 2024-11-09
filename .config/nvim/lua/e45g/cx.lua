-- Place this in your init.lua or a separate file sourced by init.lua

-- Register the .cx filetype with HTML as the base
vim.filetype.add({
    extension = {
        cx = function(path, bufnr)
            return 'cx'
        end,
    },
})

-- Create an augroup for our cx-related autocmds
local cx_group = vim.api.nvim_create_augroup('cx_filetype', { clear = true })

-- Set up Tree-sitter configuration for .cx files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = cx_group,
    pattern = '*.cx',
    callback = function()
        local buf = vim.api.nvim_get_current_buf()

        -- Enable Tree-sitter highlighting with HTML as base
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                },
            },
        })

        -- Configure injection points for C code
        require('nvim-treesitter.query').set(
            'html',
            'injections',
            [[
            ; Inject C code between {{ }}
            ((text) @injection.content
             (#match? @injection.content "{{.*}}")
             (#set! injection.language "c"))
            ]])



        -- Set both filetypes for LSP and other tools
        vim.bo[buf].filetype = 'html.cx'

        -- Add HTML and C specific modules
        local ts_modules = {
            'playground',
            'textobjects',
            'refactor',
        }

        for _, module in ipairs(ts_modules) do
            local ok, _ = pcall(require, 'nvim-treesitter.' .. module)
            if ok then
                require('nvim-treesitter.' .. module).setup({})
            end
        end
    end,
})

-- Add specific TreeSitter text objects for HTML and C
require('nvim-treesitter.configs').setup({
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- HTML objects
                ['at'] = '@tag.outer',
                ['it'] = '@tag.inner',
                -- C objects
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                -- Block objects
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']t'] = '@tag.outer',
                [']f'] = '@function.outer',
            },
            goto_previous_start = {
                ['[t'] = '@tag.outer',
                ['[f'] = '@function.outer',
            },
        },
    },
})

-- Optional: Add a custom command to format both HTML and C code
vim.api.nvim_create_user_command('FormatCX', function()
    -- Format HTML (using prettier or your preferred formatter)
    vim.cmd('normal! gg=G')

    -- Find and format C code blocks
    -- You can integrate with clang-format here if desired
end, {})
