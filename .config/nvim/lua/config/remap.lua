local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', '<leader>rn', function () vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', '<leader>ca', function () vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

vim.keymap.set('n', '<leader><tab>', ':tabnew <C-r>=input("Enter file: ")<CR><CR>', { noremap = true, silent = false })
vim.keymap.set("n", "<tab>", '<cmd>tabn<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<s-tab>", '<cmd>tabp<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<leader>af', ':ALEFix<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>an', ':ALENext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ap', ':ALEPrevious<CR>', { noremap = true, silent = true })

-- spell fix
vim.keymap.set(
            "i",
            "<C-l>",
            "<C-g>u<Esc>[s1z=`]a<C-g>u",
            { noremap = true, silent = true }
        )

autocmd('FileType', {
    pattern = 'tex',
    callback = function()
        vim.keymap.set('n', '<leader>q', '<cmd>!zathura <C-R>=expand("%:r")<cr>.pdf &<CR>', {noremap = true, silent = true})

        -- Quick compile and view (you already have <leader>q for zathura)
        vim.keymap.set('n', '<leader>lb', '<cmd>VimtexCompile<cr>', { buffer = true, desc = 'LaTeX build' })
        vim.keymap.set('n', '<leader>lv', '<cmd>VimtexView<cr>', { buffer = true, desc = 'LaTeX view' })
        vim.keymap.set('n', '<leader>lc', '<cmd>VimtexClean<cr>', { buffer = true, desc = 'LaTeX clean' })

        -- Quick math mode toggle
        vim.keymap.set('i', '<C-x><C-m>', '$$<Left>', { buffer = true, desc = 'Inline math' })

        -- Quick emphasis
        vim.keymap.set('v', '<leader>e', 'c\\emph{<C-r>"}<Esc>', { buffer = true, desc = 'Emphasize selection' })
        vim.keymap.set('v', '<leader>b', 'c\\textbf{<C-r>"}<Esc>', { buffer = true, desc = 'Bold selection' })

        -- Quick section creation
        vim.keymap.set('n', '<leader>ns', 'o\\section{}<Left>', { buffer = true, desc = 'New section' })
        vim.keymap.set('n', '<leader>nss', 'o\\subsection{}<Left>', { buffer = true, desc = 'New subsection' })
    end
})
