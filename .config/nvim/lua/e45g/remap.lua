vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', '<leader><tab>', ':tabnew <C-r>=input("Enter file: ")<CR><CR>', { noremap = true, silent = false })
vim.keymap.set("n", "<tab>", '<cmd>tabn<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<s-tab>", '<cmd>tabp<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
